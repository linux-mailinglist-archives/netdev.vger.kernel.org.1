Return-Path: <netdev+bounces-205300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA3CAFE263
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7191C170181
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9E92512D7;
	Wed,  9 Jul 2025 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Io91Noim"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F59623C4F4
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049294; cv=none; b=iOlleZGbWMdkGhyodWH+J3xPDY+ga4IrpxGfu+iE2vF/puCtS7fzwSBij5PUizk9TWpiHk55qJZxP4EUfi3IPHxhQaCHx+zMMWhOEL3MF3SuXLwYW1L2f59TTyZgY7z+LR5Wq3BpmV3BD4eioL4RyZn2D9z+/gDxygV6CLpgnJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049294; c=relaxed/simple;
	bh=ckyRm0enfVjmN+8bEXMCVszo05DaltDdfV8EKcYo2zU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KUuXbxDScWukWl5DzlRSQa/2/6k5NKiTx+dr2LtFqdM7Llb0I58Awp+BRsbnvPSKIbmto4PKnlb6NLu18J8QrMtB8JdH9HPb3CCksP9719hIaqFtA641L2VWwO39mE2VtJ+kya3GQN7X2UHJUAAwrHAZf5OMrS4D4b0dEAT2zYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Io91Noim; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-adfb562266cso840980366b.0
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 01:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752049291; x=1752654091; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IIY1qdYnNRSWia/sQ0DcpA+sma7gafJUV5CauUUesdU=;
        b=Io91NoimUWJVbkuv8hdq5FGo5UogO4bsYktaXa9txZFS2RVZ/UgBAdBMfrDmb7YSfL
         lnRpsfPCSWgQd0RbsoDFAztN1UPcsZBjTEJT/22McpYb3LD0GsiACMWNpbfpGIEr4JnK
         eWG9g/pAmTH7Rog3xu1GuLh3Q36V8GRH7Le1Qi6UlYqtUYdOnjgGg356mtXOvMJBwDC0
         cTHn9IHqNGp9RWWhDI8fJ/vMe0WZ08P3ISZCRtWWdWu/wOhBMbla54qGQlgSIA0Jf6tZ
         bMOp/acMu0HUpEwqcLPD2z4hr/+6HfneyFRTSBCStRiumKiyt4fN/drMXaDJ+U7cyFH5
         ugDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752049291; x=1752654091;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIY1qdYnNRSWia/sQ0DcpA+sma7gafJUV5CauUUesdU=;
        b=b54ph32hwGbXaryxAMoru/bW7chjEctwmsUD+98gD7OQgLfzB8FJSHlnBWB8LxbcZG
         fpY4th90GsK2DMmzxJWMOvV7CmhsS/Ati6eXsstHNAan6ptIpwvaeOQhkJy3VuV+4jM0
         hEg3u1Gv1ZH7GDHJvWal1Ht/zLYMa7I2zvddAtlqtiHo5eSyM8KHlHlg/IG7CHfsEb1x
         tutGChcw1Czfvv/YXoHo7yHiUMMi1gDW735k+eDyVt8OqJRbQ7V4gri0NeoeilKE8CEg
         6P/ni1zzanB96/WUFyNUFpd4qIUvXBeakpGNibyVpRgwUDpoErOBn92r+vcskxoOKkdr
         MATg==
X-Forwarded-Encrypted: i=1; AJvYcCXPdab56rFG9l37p+0TwVXTrhJTSrl7gqlHmcRMhikH35qngB3c6eqSC8t4hioXj256BhnORNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBi7r7WHIX/QiGRPC9aFBVsYN3l8Bu/SiXas+b2hh1fo40QveU
	rIpS1rIld+kdUVucuFgR0qC+72PXrVHG/66OOjdxuzxZ7nZgVlseE+h+VR6xeEhvuG4=
X-Gm-Gg: ASbGncttWXMHla7Zx/O+CESkd4n43aL3BVWEOgETeAYmv3eTLkjX+Hp/gPEnjqsDboB
	dDuSFE5EZ+tuQpP6zVo0lKan0fWX3EMRTHhvDAkhzFgux4DC35J5gss3RlBIrEo/rE3cEBXvArS
	h6I18+Wux8OVpSKCbqnwhTNbMmCQuv3xGWxJ0JxfkysEUircB+MJQTJNj1r0fIuSC0lSB34bhSo
	sMooq6BP2zSqa8rkERUVeurfunfwVs9oxFaBylRDH+V6SVvG9VCk95Y2Y80b5jWze6F2HHfhTKE
	MFqkeos2XPoVwS3TCK1ONYsvExb+LhmEstBSRVILUJ3WYOyvVrFAAFs=
X-Google-Smtp-Source: AGHT+IGfHsYxZ/BQIrPnRIlZl++93uSpuvwPAd/R6OibEs4U8BXiJ1ECoDNeSW6UPcLJalW4MgZSaw==
X-Received: by 2002:a17:907:8694:b0:ae0:b46b:decd with SMTP id a640c23a62f3a-ae6cf7621e5mr183572366b.31.1752049291233;
        Wed, 09 Jul 2025 01:21:31 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d91ffsm1061547466b.14.2025.07.09.01.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:21:30 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Tao Chen <chen.dylane@linux.dev>
Cc: daniel@iogearbox.net,  razor@blackwall.org,  andrew+netdev@lunn.ch,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  ast@kernel.org,  andrii@kernel.org,
  martin.lau@linux.dev,  eddyz87@gmail.com,  song@kernel.org,
  yonghong.song@linux.dev,  john.fastabend@gmail.com,  kpsingh@kernel.org,
  sdf@fomichev.me,  haoluo@google.com,  jolsa@kernel.org,
  mattbobrowski@google.com,  rostedt@goodmis.org,  mhiramat@kernel.org,
  mathieu.desnoyers@efficios.com,  horms@kernel.org,  willemb@google.com,
  pablo@netfilter.org,  kadlec@netfilter.org,  hawk@kernel.org,
  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
  netfilter-devel@vger.kernel.org,  coreteam@netfilter.org
Subject: Re: [PATCH bpf-next v3 5/7] bpf: Remove attach_type in bpf_netns_link
In-Reply-To: <20250709030802.850175-6-chen.dylane@linux.dev> (Tao Chen's
	message of "Wed, 9 Jul 2025 11:08:00 +0800")
References: <20250709030802.850175-1-chen.dylane@linux.dev>
	<20250709030802.850175-6-chen.dylane@linux.dev>
Date: Wed, 09 Jul 2025 10:21:29 +0200
Message-ID: <874ivlg4fq.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 09, 2025 at 11:08 AM +08, Tao Chen wrote:
> Use attach_type in bpf_link, and remove it in bpf_netns_link.
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/net_namespace.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
> index 63702c86275..6d27bd97c95 100644
> --- a/kernel/bpf/net_namespace.c
> +++ b/kernel/bpf/net_namespace.c
> @@ -11,7 +11,6 @@
>  
>  struct bpf_netns_link {
>  	struct bpf_link	link;
> -	enum bpf_attach_type type;
>  	enum netns_bpf_attach_type netns_type;
>  
>  	/* We don't hold a ref to net in order to auto-detach the link

Nit: Doesn't that create a hole? Maybe move netns_type to the end.

[...]

