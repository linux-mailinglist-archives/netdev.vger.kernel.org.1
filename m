Return-Path: <netdev+bounces-121454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2272795D3D6
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 18:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54ED2844C1
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4FB188A1A;
	Fri, 23 Aug 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMq9rtbw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C828941C69
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432321; cv=none; b=hWd6NCXk05wlg1T2wS12d/a5YtMm6oO3pGyUKl6lOYTqt8Rw6MI6IvYY5bhekk2R3V9JTEGRnOoAwbOLsOLkC0AUPr6b9VZJ4oZ9wT8x25Rlgz6u7IlQFMqjVTlqgNjTVVQASutRb0/5SEIJBpFYzFac/HkvNdC+YprwfgWkKn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432321; c=relaxed/simple;
	bh=O8/A8YiBwZQtMblwjv9iC3POYBgzLhh9zWSBNVEdZmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4OVjAEz+4SNo9zk/AIWvRroSh1pKzWnNvyaTLCCOqJB/MY3ZpFmOMcQ9WSoJ1MFX/xTZRrG5mIkiyhC26oKXvALsc3LK7jjYF3V7nBz9IzwoS3Lvie13Tf2VhdhS1e8Hbb2z7W8u4jfRgEZpwTZyQpoS+jduH8JAQ+u3VDhH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EMq9rtbw; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bed0a2ae0fso2791060a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 09:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724432318; x=1725037118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eno3+7waxBHUc2l2Zyr0fzWW/5VQcedIuO58791HC0o=;
        b=EMq9rtbw1BmSUiVG+kfk/cIIIwcYSai4wWDdLtDg9lZ+fQAuPUnUX+QS1lZlyypgvI
         GuqvMOsJr4Foe4FAAyPeU8DoCHrh/UMm8/DXhPnokwxoQBAZobkEbuoUdLVOScGJqUMN
         unP4GukiZG2hbK41ivCuU/LOhP7gxyL+gWn8TQ4RQ8An8VIcANidjpoMV2uB+AWx8GO3
         Vnb8RzDfa5umTkapnGQP3C3difCDzSZ3rGlOgmstX7ZKKfjwjbPO3vxuQ015lASVc39b
         0zlD1ilhpmyQ5CL4ONpbIJTLlW3xUUBk0U6G7xvYfpiLqnjRxdEoyIZIzVcjPNh0yfJJ
         9kdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724432318; x=1725037118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eno3+7waxBHUc2l2Zyr0fzWW/5VQcedIuO58791HC0o=;
        b=uGNNo8Bp52EIjdiFO/nbJUSTwwU3obhHZiX8B0Ocv/Nw1j+vAxqAj1AyPb3ZbvFIc5
         0yTN0J2bNrmc8ch6TzQ4jAUb4MbZ3s8foaUetrDVbgAybAg/bCCn+E6/PbHgNoeDupbW
         SjFMsodOTKZglGWdTM8swTgnKQK0VQn86KA0014y4ScxqNtabNYdzTnfkWU+8ObAT3IY
         F7kDtBl52hJq8W026bCSVz/J+G6ZT8AlgFJQUrFE5Noe5uDYt4CEZbaxBMtJNPEFbyVG
         PO6+u0WS5FCFGse0Z2y6uAEjd7vsZ8SrN3Yh/T739TBfg/K9mIafBkFUAsPAB1Wuk/wk
         kmTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9YbdKNNHYoJcEEmBeu15rz2t2f1WPnv/zz73eLKMEkVO7C40GymEHbIU1pQV3YYLLEnTPHLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPblMTLCjeFHQSE5YBJSlihYUR72/O0QKyrKVqY9SFdhWizz4
	qZ1cEdKQZHsRXFK1xekZGLYiCWInOvEMeL6kTLK31DqQV2PQhkU84g5Mpti2yzI=
X-Google-Smtp-Source: AGHT+IHEltDQwnhXn5D4FlTupYbZCZW7vujaJ5jEQDRI6cMq4aP8wqDrngnyhXFNSTqCvWFTsPxwwQ==
X-Received: by 2002:a17:907:2d8e:b0:a86:83f9:bc1f with SMTP id a640c23a62f3a-a86a54de2cdmr172374066b.61.1724432317881;
        Fri, 23 Aug 2024 09:58:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f4090sm280693266b.196.2024.08.23.09.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:58:37 -0700 (PDT)
Date: Fri, 23 Aug 2024 19:58:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joseph Huang <joseph.huang.2024@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Subject: Re: [bug report] net: dsa: mv88e6xxx: Fix out-of-bound access
Message-ID: <4b004e58-60ca-4042-8f42-3e36e1c493e5@stanley.mountain>
References: <d9d8c03e-a3d9-4480-af99-c509ed9b8d8d@stanley.mountain>
 <0b6376c2-bd04-4090-a3bf-b58587bbe307@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b6376c2-bd04-4090-a3bf-b58587bbe307@gmail.com>

On Fri, Aug 23, 2024 at 10:40:52AM -0400, Joseph Huang wrote:
> 
> Hi Dan,
> 
> I had a similar discussion with Simon on this issue (see https://lore.kernel.org/lkml/5da4cc4d-2e68-424c-8d91-299d3ccb6dc8@gmail.com/).
> The spid in question here should point to a physical port to indicate which
> port caused the exception (DSA_MAX_PORTS is defined to cover the maximum
> number of physical ports any DSA device can possibly have). Only when the
> exception is caused by a CPU Load operation will the spid be a hardcoded
> value which is greater than the array size. The ATU Full exception is the
> only one (that I know of) that could be caused by a CPU Load operation,
> that's why the check is only added/needed for that particular exception
> case.
> 

That doesn't really answer the question if multiple flags can be set at once
but presumably not.  The ->ports array has DSA_MAX_PORTS (12) elements.
I used Smatch to see where ->state is set to see where it can be out of bounds.

$ smdb.py where mv88e6xxx_atu_entry state
drivers/net/dsa/mv88e6xxx/devlink.c | mv88e6xxx_region_atu_snapshot_fid | (struct mv88e6xxx_atu_entry)->state | 0
drivers/net/dsa/mv88e6xxx/global1_atu.c | mv88e6xxx_g1_atu_data_read     | (struct mv88e6xxx_atu_entry)->state | 0-15
drivers/net/dsa/mv88e6xxx/global1_atu.c | mv88e6xxx_g1_atu_flush         | (struct mv88e6xxx_atu_entry)->state | 0
drivers/net/dsa/mv88e6xxx/global1_atu.c | mv88e6xxx_g1_atu_move          | (struct mv88e6xxx_atu_entry)->state | 0,15
drivers/net/dsa/mv88e6xxx/chip.c | mv88e6xxx_port_db_load_purge   | (struct mv88e6xxx_atu_entry)->state | 0,4,7-8,14
drivers/net/dsa/mv88e6xxx/chip.c | mv88e6xxx_port_db_dump_fid     | (struct mv88e6xxx_atu_entry)->state | 0

mv88e6xxx_g1_atu_move() is what you fixed:
	entry.state = 0xf; /* Full EntryState means Move */

mv88e6xxx_g1_atu_data_read() does "entry->state = val & 0xf;" so that's why
Smatch says it's 0-15.  The actual "val" comes from mv88e6xxx_g1_atu_data_write()
and is complicated.

mv88e6xxx_port_db_load_purge() sets ->state to MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC (14).
I would still be concerned about that.

regards,
dan carpenter


