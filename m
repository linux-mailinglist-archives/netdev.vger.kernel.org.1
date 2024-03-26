Return-Path: <netdev+bounces-82310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C05888D2F3
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 00:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00021F3CBD4
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 23:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0720D13E059;
	Tue, 26 Mar 2024 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7qFDZf6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5038D13E055
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711497078; cv=none; b=LWFlfTD8vWnIsKFsG7nlOMx2OvAxNVMgEehBJZXwL+TCL4Y2y94rDNvYlH+l0fLbIZ81WUrDSvFqVLTqy2NSWvWJfmdfgeTm8BWW5xZAISsDdCXerwtws1v4j6xkZ4RX7IiiphoDNEBo+uahEV88+I3xoP/tj1wBZ2bUS0BubgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711497078; c=relaxed/simple;
	bh=wkAtvML6UcXiADpgXHP3Pa4layiMdvDBURAOvHu/QFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCHaCuynl6XLBC4I3ZVRuxP/QsC4kRdnB7HA9S8D3YdLl8X7eRMvmnR6MOuK+ihxyJTQf2wtTSNzgvi0njk5oD7iMEgoZfRC4y1/kIcLXNfFq4I2iKdaRqTpuP6wplOpLqaX0dOK7hAqg1aHa/8pEs1yY1jLSnF/6/PTzDm4KHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7qFDZf6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46daa53584so196334766b.0
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711497075; x=1712101875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+y+KDKtR0FlzJK82H0bwfON2gXEFN//7FIZm5SN0jIk=;
        b=l7qFDZf6uHFUuytFo11g+It9GxdH+ZQoUokBQT8+90O1brXBUtnpTJksjynY7hnaod
         JQsV/i9aWMLVL54FYzmxhV60XlVUkiw2glrSFLtuH22hINT6DpPMvMg3f0rMNQsKBaiV
         QhHHrVd9cCGxxdF1tn4em+zqHW3zxwQNGImo0e42WYSTVZVXBtnggQ/60uJSLRUDpq/3
         +ruQ/YOMeJ981tfU5iSLNhmvXBg+CtUOMvG/FPtVesiqNQXRyWpvdtFxui7dDfscCW2E
         rRYPpsUxOMw+Qq93mf/63fP2wDL2eXiGIrrvqW5crHRg5RF1jBOisVR+xA9RD/s05R8Y
         nrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711497075; x=1712101875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+y+KDKtR0FlzJK82H0bwfON2gXEFN//7FIZm5SN0jIk=;
        b=BQKEO+nX2sO2lqWOiDon3C8N00lCeGc/M3NrLTWSjGdc2tQgE6/avKpE2TVhVU112w
         bNTY7VO+ED3TInwmLBmiO3c0vUfn5rNzcDnzRfGcY5jI/J/C/MddbjddW6oz4WFY4xH7
         9c/7WySngexO9dMwmseqc0JUQk2Ra5/5Wr0Q9uTNbFeBO+ODs3nbrvapwaZ+sSby8ne2
         Yq7kf580FCnVjOw0ibBTC2lOEHh1R5bM41arE7vZa5C2ggSZv+CzfmpnNwCSZFZbGVwa
         BJkOvs8xfG+KNKeAzHaqJ2BzViLnYUEyWC/pzDogxqP3NTia2uOp2VxWsxWojpC4hv5H
         ihHg==
X-Forwarded-Encrypted: i=1; AJvYcCXb633tXR9527sdzLzHTQcGDfHZJR+sQf/n5loMFFtIfa75kBo21uHqPsoaGsjVBNVib8ekij7gpIbnR0oNMPuT1Y86RMl0
X-Gm-Message-State: AOJu0Yw6LIcpT1/IsbjEBe3Q17eUjtsOyu8irfAx+SP7jZHHeqx3UDnN
	1DqUH0Onm0fJ0L1EQUo/8gFD6ruhq61Vr2Asda42i4bDV0DxhRA0
X-Google-Smtp-Source: AGHT+IH5cVlQk3aSpw/HfmllGUE/8i5mRpIRqcoDvJV3CwQ7Z2JQWtTosSlqNFHwlwbte67Oe1KE5w==
X-Received: by 2002:a17:906:646:b0:a47:366b:21da with SMTP id t6-20020a170906064600b00a47366b21damr6841496ejb.4.1711497075324;
        Tue, 26 Mar 2024 16:51:15 -0700 (PDT)
Received: from hoboy.vegasvil.org (89-26-114-113.stat.cablelink.at. [89.26.114.113])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906271700b00a473766cfeasm4742690ejc.217.2024.03.26.16.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 16:51:14 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:51:12 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next] net: dsa: hellcreek: Convert to gettimex64()
Message-ID: <ZgNfcMgHt5PpDoes@hoboy.vegasvil.org>
References: <20240326-hellcreek_gettimex64-v1-1-66e26744e50c@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-hellcreek_gettimex64-v1-1-66e26744e50c@linutronix.de>

On Tue, Mar 26, 2024 at 12:16:36PM +0100, Kurt Kanzenbach wrote:
> As of commit 916444df305e ("ptp: deprecate gettime64() in favor of
> gettimex64()") (new) PTP drivers should rather implement gettimex64().
> 
> In addition, this variant provides timestamps from the system clock. The
> readings have to be recorded right before and after reading the lowest bits
> of the PHC timestamp.
> 
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Acked-by: Richard Cochran <richardcochran@gmail.com>

