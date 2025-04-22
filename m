Return-Path: <netdev+bounces-184799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38618A97395
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 19:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC517A3A5E
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EF1290BBC;
	Tue, 22 Apr 2025 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQqszmw6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B92284B48
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342843; cv=none; b=obdf6Av4HR1twUSN+nq9Wo9RPX15ZE2C0DAXaTyepQlOFd2UbWBYFnyQ3rgxMl4OkNQCiTPs6AsbbdmB3tkt4v1gZ9pmdCfMlJFJNt5Kq4UlTHwu4LRCm+txX5pZ/lsnf+XRcgCFVSHt0AxijyoxtoIZVTZxhNWnU52ZOzAoMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342843; c=relaxed/simple;
	bh=D0QymgneXaTt/3fgHr6UcxMDJUrzIZEGs9HkruuNRY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ7bh2rI/Nvh4pllxHrOkKxupX3JIHkdsH595nxb/fJkM8bbzqVWZ03HemocTP3XHas1nS9KTRid2rCY7VL8t6KuTudWISCInFMh+Tu9Q782WJJ7jPkZjDU2VX6VxSUMTtDPUHxDdxWwsjuzJzK6c8AEXAOamVfzTEhE2lva13w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQqszmw6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22c336fcdaaso60886975ad.3
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 10:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745342841; x=1745947641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Opd+J48FPKI3ZGiGg/JuYjcZrjQj8elWYQobjTII45M=;
        b=RQqszmw6QvuVlButjepv6pfReYSCoeDP049xvIwJpKijQkIcbAdhheQU1ndKmtvVls
         OyJyEmVzEHhAbfY9kd/Zz0GuP6hZgHc1XIx3ZpuqDE96ob8EU+jdfnSPOTWa5nfClCHL
         95VEO6GBWSakmijO3swkvFi4AMnflQQLF/TbeLJIVviy/Nd4fvaqMGB4oIxZIVLQ/UOz
         85dUaM71mPL09AW+/smhBR9AUnTdrt8DIVrz4W+VqdBdIKXFm07BeDsE8Kx1myBoVQSl
         lMMLWPEKp7lW3Rd8nFBo3lCuVuuiH8usuLacoRIxO+/qiAV9b9cNdO1oEL5avhqTw2Wh
         W18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745342841; x=1745947641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Opd+J48FPKI3ZGiGg/JuYjcZrjQj8elWYQobjTII45M=;
        b=k9g5cJtY73OdUZfpEryhUWmj+pd/+zqKYd3crSpz++HNopdQ8clCpU2MxQKUXx3iML
         cEeC+0VD0M8d65UxgyIrjTCTla+gN7RnQKXJIg4ydoKKUSqWd0vHO+RXpwJYHyhULSlr
         PiuPbUwPVRTMZB+GzUeDmZzVGEtnjw2nSoiAoUpKFj5zCwPLZDlOJKmfSqfnAy6b9RLc
         nO0jwbdrn6JhocHj4CPy3vAYo5MYv33jkVls1ugKoH0nqXgzYpVsEpVabIwXYG+2CY2j
         aci/zMjuVSivjN9K8tfcgFXpffIyxXgvVcnoGeHuDpmm1ADa5M3xHL2BmPew08lS9PYd
         k2IA==
X-Forwarded-Encrypted: i=1; AJvYcCUsaIZpgsIfsvi3f5BL0AIbQqRZB+PnrZjn/MkbB6nx2rGG9KDoSXQZmAJ8bex2EqAXOqf+zhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfT3od61WCUvOUzTajb5CFMD9HiYCGWIN5vWoHQmFRMkxwxRha
	Y3Qfb8H3iPvKqVRjmMZLMewHjPMw6bNxRVT5ML5zDkFrTQvWSwI=
X-Gm-Gg: ASbGnctdHcsDwmujMVzSgUKqyWTYVOumP+5gqplJPY1vU7RgOl1SoZShifwZ2eVHPT2
	ml3PN9X3xcD6GYD5aN0jN0hacvtZBk8xCuAJhGqdxeD9Fglb7N/76dniUWTXLyzHbcmP71pROqB
	4y9J+nS4HnJ3K/9rDtdyxklroLO1Uj6e8K0QVKFXQWzy0+NHenBxSO2Y4V7SIPELxgPrB6wPrfZ
	9N2d3ANJPFPUgp8gpVnXb5LeyfxkFLz0HfoNyeZBtIqpbTstw+5jmBeuJjlSIGtae5fBiG5GRCC
	4qiOZnz0wo8xooOxppepjFsMMWWZGIZuuxGespju
X-Google-Smtp-Source: AGHT+IFJxy2dFyTAGO8lGVAdWil/IemCX9zsPK2DQ+P07AzSVN4h59bZXjSdSpSViRw9Z5c5/WM0Nw==
X-Received: by 2002:a17:902:ea07:b0:227:e6b2:d989 with SMTP id d9443c01a7336-22c5362e557mr243009235ad.44.1745342840995;
        Tue, 22 Apr 2025 10:27:20 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50eb5318sm88172095ad.107.2025.04.22.10.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 10:27:20 -0700 (PDT)
Date: Tue, 22 Apr 2025 10:27:19 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
	dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
	jdamato@fastly.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 07/22] eth: bnxt: set page pool page order based
 on rx_page_size
Message-ID: <aAfRd__DgRYfgubF@mini-arch>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-8-kuba@kernel.org>
 <aAe2jaAUi0-deSeI@mini-arch>
 <20250422085237.2f91f999@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422085237.2f91f999@kernel.org>

On 04/22, Jakub Kicinski wrote:
> On Tue, 22 Apr 2025 08:32:29 -0700 Stanislav Fomichev wrote:
> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > index b611a5ff6d3c..a86bb2ba5adb 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > @@ -3802,6 +3802,7 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
> > >  	pp.pool_size = bp->rx_agg_ring_size;
> > >  	if (BNXT_RX_PAGE_MODE(bp))
> > >  		pp.pool_size += bp->rx_ring_size;
> > > +	pp.order = get_order(bp->rx_page_size);  
> > 
> > Since it's gonna be configured by the users going forward, for the
> > pps that don't have mp, we might want to check pp.order against
> > MAX_PAGE_ORDER (and/or PAGE_ALLOC_COSTLY_ORDER?) during
> > page_pool_create? 
> 
> Hm, interesting question. Major concern being that users will shoot
> themselves in the foot? Or that syzbot will trigger a warning?

Yeah, both, some WARN_ON in the page allocator. I did trigger one for
MAX_PAGE_ORDER at some point, but not sure about PAGE_ALLOC_COSTLY_ORDER.

Just thinking from the overall setup point of view. I'm assuming that if we
are gonna support >PAGE_SIZE devmem chunks we'll have to tune rx-buf-len
_after_ we've bound dmabuf to the queue? (otherwise we are hitting those
PAGE_ALLOC_COSTLY_ORDER if we do it before) And there is no revert back
to reasonable rx-buf-len on unbind. Or for devmem we'll have some TBD way
to communicate "preferred" rx-buf-len per queue (derived from the dmabuf
binding itself) during the bind?

