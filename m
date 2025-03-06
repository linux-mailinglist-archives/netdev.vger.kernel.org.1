Return-Path: <netdev+bounces-172376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C54BA546DF
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457B03A6AA4
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F3620E326;
	Thu,  6 Mar 2025 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FPQwYYLC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE0D20E014
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254543; cv=none; b=cLk10LRuniwG10Fy0mxQYfCNnvy6+dF/oP07oK8GyZ/cHNi7f247v8VjA/ZvVDYwcMAjMlaNi/G/7JstYPdX1NNoK27w+1G4O+ONhxgy74dTsq69DUNud7uXYYVI26kViGBzVWAG7ASOmtR7koHAQak1x4D+j/ldScYPpYwHAL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254543; c=relaxed/simple;
	bh=A5NmoH8yP32q/2jOv2lRobHqEgQ4kRrORqLmA066nbY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LJxFybDpOCwsObWgetR0/0DZpLucu45zSuvWO7nbvN4ra6ErZNHfylALxw61o72a3rDIc5CJUVF5eJBXs9564b/AxaKdH39RJt1b0fpB39+rO2tlM3+5nyOMGk8FeIT19nV3/AEnW+4A/UdoDYvGx+Fg9tQHPwE1NtJ4GFJG5uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FPQwYYLC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bc638686eso11254325e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 01:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741254539; x=1741859339; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8QWMjorl1Mo99mLhFcq/dfl5NW+dP2Lw/1BLHRiL2jk=;
        b=FPQwYYLCEpgspqeYAWRVPiIY6Z2Yx8XOFUiRl0xdOsJxji0MzMD0QVTEfEIhJc242t
         yE7KiZHGSY839kNbUuu86mjG7u+v98pmf7GNkS6qrTvMwWWYk4Lg3IK/ozPBVlQe/kZM
         69inpdt9aaw90otIvrREKKsVosZpHQB+YK39wiVU+826q/JLRJEK2DVeEkW3BGx9CdbF
         PIDFXZ8Ukmz247zRJZsQ9Fmq8polNOC18oVHvOvVDIW7c7Wn5sfgG4rmRuWKhYv9SLvb
         Me//zDUM2zBRUsccA6hbkdR6WQ2aLtkaa5QOkRvNeifk5JqJWCCWXWQK/A9DiJyw8MhG
         oRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254539; x=1741859339;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QWMjorl1Mo99mLhFcq/dfl5NW+dP2Lw/1BLHRiL2jk=;
        b=G6D4wH7AZa1Cz5t/MMzI6LXvWEq8/xGgFTXniDYetkwevjx6LymU0uyvOWW14IsO9y
         e0juLwzUlt7f8anXlDwJMK+itqGvZIEbVmVnF55igPNpvODLB1B3qdxma2aZ1qomFRoN
         wuK7VZBCymLvlIgWPdX1bgdI7HBz3X+zexh0onfP8tVRUmcVImC5ZK45UXP30eUUNIVG
         MhLbE/a+MS0xsunU1t5K7DLTSntvv0oAgis99nKQIdaUz7p/YbeEG1CuuLeYo0cdsUqO
         2FS0iwVxVAFtx9GtAa3W1hyGe7nNhbTc169bIqPdy1tAQT2yDNd+KQsfNrgc3ZCzDTpS
         j66w==
X-Gm-Message-State: AOJu0YzMvKHxJ2bC8RTELNfD7Ge4Uj0zvk/iIsvrBo2vr5g/2qyUBdEi
	W6tYIMOmi9ZmaInbkETT3yaQ5h1igqagJGRkDpbOo7g7pVIf5mW6ilracQaseDo=
X-Gm-Gg: ASbGncupB86clLcYY3OoFuyJhMFlrrDyLi6cDzJWqukU+Oo6xRUMZjg6pr69CdYX1PA
	uJwhfNAE3JxHDEMF6n4GWqpSTTFWrw+r+FdIk5RsOijo7n46IiQd2rkTNuuJleMSDLcxCqOvFbn
	sf+XuROM4vmqoGKA9LYuVIaC0zbiTFv8oJds+/DRYQQV4CKjrXaO/PWlRv1ImOaNJEtghtUp1Vx
	NOUHwFlBAYIVkKKPg7P5v9Y7ILfDTQHr2I5zVLIONpQ8ggaPr8S4cEx27kAiEoDibsb5WN00Tb0
	WCP2KSrDxOmZKYQi5SAQxi/WyrfAB3++KSkPgySOUksPIBA+Ww==
X-Google-Smtp-Source: AGHT+IGcNr+XyGPDPv5X6EFckg45gA62yGJiqRPt1attHJdJ1FyHPfH+V4gyw7/fxKQ8mpOSRHOFGQ==
X-Received: by 2002:adf:9cd2:0:b0:391:2e6a:30fa with SMTP id ffacd0b85a97d-3912e6a3248mr603141f8f.27.1741254539486;
        Thu, 06 Mar 2025 01:48:59 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bdd8c3173sm14931385e9.11.2025.03.06.01.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:48:59 -0800 (PST)
Date: Thu, 6 Mar 2025 12:48:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org
Subject: [bug report] net: pktgen: fix access outside of user given buffer in
 pktgen_if_write()
Message-ID: <36cf3ee2-38b1-47e5-a42a-363efeb0ace3@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Peter Seiderer,

Commit c5cdbf23b84c ("net: pktgen: fix access outside of user given
buffer in pktgen_if_write()") from Feb 27, 2025 (linux-next), leads
to the following Smatch static checker warning:

	net/core/pktgen.c:877 get_imix_entries()
	warn: check that incremented offset 'i' is capped

net/core/pktgen.c
    842 static ssize_t get_imix_entries(const char __user *buffer,
    843                                 size_t maxlen,
    844                                 struct pktgen_dev *pkt_dev)
    845 {
    846         size_t i = 0, max;
    847         ssize_t len;
    848         char c;
    849 
    850         pkt_dev->n_imix_entries = 0;
    851 
    852         do {
    853                 unsigned long weight;
    854                 unsigned long size;
    855 
    856                 if (pkt_dev->n_imix_entries >= MAX_IMIX_ENTRIES)
    857                         return -E2BIG;
    858 
    859                 max = min(10, maxlen - i);
    860                 len = num_arg(&buffer[i], max, &size);
    861                 if (len < 0)
    862                         return len;
    863                 i += len;
    864                 if (i >= maxlen)

Smatch wants this check to be done

    865                         return -EINVAL;
    866                 if (get_user(c, &buffer[i]))
    867                         return -EFAULT;
    868                 /* Check for comma between size_i and weight_i */
    869                 if (c != ',')
    870                         return -EINVAL;
    871                 i++;

again after this i++.

    872 
    873                 if (size < 14 + 20 + 8)
    874                         size = 14 + 20 + 8;
    875 
    876                 max = min(10, maxlen - i);
--> 877                 len = num_arg(&buffer[i], max, &weight);
    878                 if (len < 0)
    879                         return len;
    880                 if (weight <= 0)
    881                         return -EINVAL;
    882 
    883                 pkt_dev->imix_entries[pkt_dev->n_imix_entries].size = size;
    884                 pkt_dev->imix_entries[pkt_dev->n_imix_entries].weight = weight;
    885 
    886                 i += len;
    887                 pkt_dev->n_imix_entries++;
    888 
    889                 if (i >= maxlen)
    890                         break;
    891                 if (get_user(c, &buffer[i]))
    892                         return -EFAULT;
    893                 i++;
    894         } while (c == ' ');
    895 
    896         return i;
    897 }

regards,
dan carpenter

