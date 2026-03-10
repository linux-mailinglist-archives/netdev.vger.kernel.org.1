Return-Path: <netdev+bounces-265855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHgvM/B9r2nYZwIAu9opvQ
	(envelope-from <netdev+bounces-265855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:12:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D9A244173
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F1A4319964A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A2630E830;
	Tue, 10 Mar 2026 02:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZkmR1tbD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB73112B3
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108401; cv=none; b=dAvvBJS6jG2eFOuoQ3oK9ZapoJ47USxd6tU8K3nlyyYzR238kO96eKkzY9LMKg89GpBtVxgM5wqQUYlfAshsUio9EaExhc/SRhFIheWqIbcGsY38pCQ7bZgxv+3S/jbrNZ4LHm6yx7JwiKl06TQTBPcJ4OqWEg9CtXnEIXYwR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108401; c=relaxed/simple;
	bh=TTdpw+ZfrEr36ZVnmAy/7MfXfSaLw+69NkvcyoTi0LM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRAH4o6lHyzEyfOLGu2Ped+g6g6XcIBb8mrE2CAN885W8tFBDRmBA4isSYybqjipQRbTaXKzZiT3CO+KM2wbvmgtklWkSuwLbW+PJPfl0zIN9IXQ0+AGOA+zpgCa+LB5CIqiBxsM3ypMpU9oKTcGzueX6jC8p1UR4PhrGCrh4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZkmR1tbD; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-67bb04151dcso1162793eaf.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 19:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773108399; x=1773713199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qppXRsV2V/FmRBwf00yJrZ1V5d8XLH+BfF9hDiyjOds=;
        b=ZkmR1tbD7JD/UAlbOXzkk2bZFL9mxsjqcFZmiwbLn39PylDC7ophl96ywfQJ3B5FAh
         bjmIq6dfD94ntBD9FFU2OOKta/A0aEGBrN6Gf+AQl1+1qYQeYuCsXc8gy4ecuOPfdOVA
         q1QEa/Ri4JXt0BQZBF5WvRzzBE6H+VJzj85rIVAj4yGGBfqIjKzGny4Cyz/0BWCc6KOy
         CnrzSeCvskK9fh2ZTGcVm/KnavWHAVGKhE5fhN2CQgJnMbvAsqNmpeKhIwzjeSzSKzno
         k5+ET5TrK3BdWPtumLckP7fnkuPRQ7JzQjKz+PdBTt4Qcnq3l57e7f034VTbMVRnY69B
         boQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773108399; x=1773713199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qppXRsV2V/FmRBwf00yJrZ1V5d8XLH+BfF9hDiyjOds=;
        b=eenjt8ImkrYloeGjhVKlprwYRU7dqTtLccNqolF7vpQ4YzCNYefa458J6CKaEko2nX
         VsWXQpTYtju8ym63TnnnSrNY6jjCHZcGvXqzUOni/QVj8rbvj+9oQdSGSQ/1sw4KFcDO
         +lpjZ4BGjaJulHAFDn37Ip/3ruNhKJQAOJYZpk3vbXCIBt6Go62m8cvMSQMOnxeFdyuR
         ZZmaOskKX4GPCXeL5VluXc+aKZkAy81twGKC+ngXyEGGvGYKIcA4X7K+VA3pYcIPrcNR
         VqXa3/JX5c8LTDbXFLtqxw1IZ3ohAWyzu1YkJn/qtkJ5smpDWyiVWPnINFfZnucrL41Z
         lBDw==
X-Forwarded-Encrypted: i=1; AJvYcCVE/IsFImoHV5jfKv/R+iiunSwWSYlyL9JLALXxGq3IgDoBtDa+CRg1xIMWhBft4nFzX6rFqeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWnqeoCyJy+fVxf/Ye1KhYPDPhaX2OmV6ZbyMV5VDPCSVFWZjK
	7OBLsB63WaSU6FwbV+NqvZ6mf8jr3e3PVBisGE9qaNqC83Fdw7mJLdyzZuPqWi+xrHk=
X-Gm-Gg: ATEYQzxwBw5tAXxJm020x5WRd6QgjV+OHmKr5Sd+S0NBxZX4F61BTGmFey3tgUJRpWm
	Jk7jV94S/WMKDbruu+lAsRx7Qdf5axyIEi4RuGGhTNzET9NE5zlk7QUSrXdKu0CC0btEYGMl//0
	YB+qpfce49Qxk81CtnusVDyklbVUFqE5uTfRfghe7L300FofWtG8VEGxQevIiAmeGDGCnt75Ecd
	31sRxem9DzCUIqA9/jbsi3OplVL14Ope/X+2CDSOVSCFBYMA4LQvQ/m8Y2x/QKU9zhogWGIp/kM
	hKeMjpBUlKSwx/sDndLSQDzYLphbycbcPOjc+XVyWlL8JxYrrT/AqQT6gTCg0EqlIdxEIRn3AfW
	IGD2mpLayAnRTuTkHT2ESCBUZsGU/cPI+ZDGig3TnF8ABG1AQye5UeY3NkfBM8YDH0DwePHjZDj
	0Q4p59LA==
X-Received: by 2002:a05:6820:2910:b0:67b:b337:d426 with SMTP id 006d021491bc7-67bb337dca0mr3993811eaf.61.1773108398883;
        Mon, 09 Mar 2026 19:06:38 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac1:76c0:540::22e:5f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67babf360b8sm4341204eaf.2.2026.03.09.19.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 19:06:37 -0700 (PDT)
Date: Mon, 9 Mar 2026 21:06:34 -0500
From: Chris Arges <carges@cloudflare.com>
To: Joe Damato <joe@dama.to>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/5] bnxt_en: Add XDP RSS hash metadata
 support
Message-ID: <aa98qgA1AapbUCiW@20HS2G4>
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <aa9rGglS62WGgSMk@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa9rGglS62WGgSMk@devvm20253.cco0.facebook.com>
X-Rspamd-Queue-Id: 30D9A244173
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265855-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[dama.to,broadcom.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,cloudflare.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,xdp.py:url,cloudflare.com:dkim]
X-Rspamd-Action: no action

On 2026-03-09 17:51:38, Joe Damato wrote:
> On Fri, Mar 06, 2026 at 05:00:15PM -0600, Chris J Arges wrote:
> > This series adds XDP RSS hash metadata extraction support for the bnxt_en
> > driver and includes selftests to validate the functionality. I was able
> > to test this on a BCM57414 NIC.
> > 
> > Note: I don't have hardware to test v3 completions at the moment.
> > 
> > Patches 1-3 implement the driver support:
> >   - Patch 1 adds bnxt_xdp_buff to wrap xdp_buff with
> >     pointers to the hardware RX completion descriptors and the
> >     completion type. This is similar to other driver implementations.
> >   - Patch 2 adds the xmo_rx_hash callback for CMP_TYPE_RX_L2_CMP completions.
> >   - Patch 3 adds handling for CMP_TYPE_RX_L2_V3_CMP completions
> > 
> > Patches 4-5 add selftest coverage:
> >   - Patch 4 refactors common BPF map helper functions out of the
> >     existing xdp.py selftest into a shared net/lib/py/bpf.py module.
> >   - Patch 5 adds an XDP metadata selftest that loads an XDP program
> >     calling bpf_xdp_metadata_rx_hash. The test skips on devices without
> >     xdp-rx-metadata-features.
> > 
> > v2: https://lore.kernel.org/netdev/20260303024510.644962-1-carges@cloudflare.com/
> >   - bnxt xdp: actually fixed RCT issues
> >   - bnxt xdp: Added patch 3 to handle CMP_TYPE_RX_L2_V3_CMP completions.
> > 
> > v1: https://lore.kernel.org/netdev/cover.1772211065.git.carges@cloudflare.com/
> >   - selftests: moved tests into net/hw
> >   - selftests: fix pylinter errors
> >   - selftests: add check for no error count
> >   - bnxt_xdp: followed RCT for variable declaration
> >   - rebased on net-next
> 
> I think I commented this on the v2 [1], but it would be super helpful to put
> the summary of changes in each patch itself to make it easier for reviewers.
> 
> I think you dropped my Reviewed-by's, so I'm not sure which patches changed
> and which didn't :(
> 
> [1]: https://lore.kernel.org/netdev/aacsQvvOoL29Rvyw@devvm20253.cco0.facebook.com/

Thanks for the reviews and feedback, I'm learning. So when re-submitting, I'll
be sure to keep your reviewed by if nothing has changed. In addition I'll make
sure I put the changelog in each patch rather than just the cover letter.

--chris

