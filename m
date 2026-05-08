Return-Path: <netdev+bounces-285885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHz9FUT+/WkdlgAAu9opvQ
	(envelope-from <netdev+bounces-285885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:16:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B61004F885F
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C19C312AD40
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A50F3FD145;
	Fri,  8 May 2026 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1DV9bSP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DAB3DC4C1
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252617; cv=none; b=qwE5qIo/uGYvLSLwNPbGgR/ypoAiES3aKIblzt25mznmRNghwqtcfM3RRuXGGPNOrqey0o6bUkSGjBm4dNX/NM59uI8kOYf0o2bynd8gD6wBDOecE/U0WKDl8R1WruEMzaR2a1PUXfQTMDM3x8v9McgkYWcjkFqMvmR2F5EMrlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252617; c=relaxed/simple;
	bh=t0Nlu+VexUsTkUu/gem9W65q4/pks24oKx+COgMx/io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFgvpRwHEFdtuW6za7vIHwZ7rmqI1wS9xEjPdC61bPnQOw0/f5T8oe2pHwnS5FGg3deAMp4byHDOAbv4hPpu20iiSJlAUqwNYzw0xWBUg3/o80hpG1mBXLo4I+2IgU21CgTrWUJ3acE2nnqBz6OGxXjfZiwPfHtLAQQcuNu5m+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1DV9bSP; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2ba928852a5so14542655ad.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252613; x=1778857413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4XSckC+6HeNNAT2ObXLyFDVqOgPjF3vQM49fr0+IcA=;
        b=M1DV9bSPdIpo1HCzS+chpKLRw9yZEaLHH4hWt/8vF7kwxIMdWiQ56TFDetp2fD3dHK
         R0u+n+5f4iBWZtmqUudWXsg0H8PaVHkUHak4NyF4Yl/tD9W5Q83ulCRhidXVrpgwF1zy
         OxnEv1kIXlzfCWOaLDPy/oadOs/Vnb/U/6AFDW6eOaaZEx/e9U2TiiVYVT0MOCDY7TlL
         C5LkiulOrgIE+dbWiLgv+jXSyxNRbrdi7pje/7CMtnoub8nb+Fa/L6vaaBQZ9ozgoVvQ
         9Ia6bUMPwXknOYTSdI9JX8ETBTps+Uue9bS/EYFde3ymahVl65AjQ81p4ufqD8Cn23Aq
         FXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252613; x=1778857413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4XSckC+6HeNNAT2ObXLyFDVqOgPjF3vQM49fr0+IcA=;
        b=KadTrWSLmOa5DS2EyI8Ta8z+Hzr1YSC+w4n+yJx++b7P0CTxdq1nsXUmGWu+IxnUvG
         Ws2X6g0AQbsVdSd2iblFcqV6thDrUkkAeJW/UXekGjOC5g5orwcZrlV8/fpULlsXXdc8
         DNprSRbFD69auhrHjLs5PFShtrel9Zab9j/ZvU6jtfah/hqXDzXK4ijU2NiY3MfcWm2X
         JQUr4vkqYUz9m+ctpBg1lvHsplr4AmFD6uaUHdETCfIi91Y3U3DEyB4jFO5M9D5go0ah
         dMYdwkswt/1cZ4w6tcskUvhH9fH0TNWb1+zRJBtvP8FfhNq7qpuZUZV6jG6vpv61wqDx
         2jgg==
X-Forwarded-Encrypted: i=1; AFNElJ8HqUi+7pw7yrmo/SEnVN4mFFFXrISnAbEru4qQguDXAEys2sGnTmivHOwHDrNxco4c2CZSTrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjNaKcQn91ROxqi6hRv2HJ0fT8zee+duW5+B1Vw3M+4tJ/z7Je
	LIDo3vBarP4HyRKcbmipGdgwIdhKulZM9zOhyXGX/whL5oxWqj3Bk+7h
X-Gm-Gg: Acq92OF4CoEiCfnYIRnZPaVKPs19gtbPy+SpLH8ZLimHCmWFtiiiCR/v3S2tiFuy3R3
	+F+pdEBV5kHF/OcMBuFRGgUuJqBOdcVbCy6Um0wEOovC02rYG2m6t7PAKIoh7JJowtIkLyUrGWE
	4bQ/6PNsk9rnHiUzkAnpOb4U8LCYX76iia6nTB1P7iOoh3A0YzqIgTPa7vWXub8IKa3faBjFiIs
	sfyUhSOqs1u5+ACWTd3TE0PTfi14WDIvs3lk7JLjj+Kiq5BFs9kQDym4/OPAMEE2d+t0lrNGiLY
	RBPMazX5DRJW+bOSnkw1eAkid7RH8+asIKmYrV2iblpNdrcsyu5SD+3q9yXvpFrM41cQafMxKCy
	s6X7Fzbj/8hv8urIxxjXCl6J32GniIZPnLCJu2Eqi19qFQamlaN4EHLnR32v79VB3IAOXJehXkV
	eq
X-Received: by 2002:a17:903:4b0d:b0:2b0:bed1:46f7 with SMTP id d9443c01a7336-2ba799d5f4dmr143685845ad.37.1778252613411;
        Fri, 08 May 2026 08:03:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ecc4bbsm24477685ad.84.2026.05.08.08.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:03:32 -0700 (PDT)
Date: Fri, 8 May 2026 08:03:32 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 7/8] selftests: drv-net: add
 primary_rx_redirect support to NetDrvContEnv
Message-ID: <af37O7TXJm9wPl1h@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-7-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-tcp-dm-netkit-v3-7-52821445867c@meta.com>
X-Rspamd-Queue-Id: B61004F885F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285885-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,devvm7509.cco0.facebook.com:mid,fomichev.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 05/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> When sending from a namespace that has access to a netkit device with a
> leased queue, the nk primary in the host namespace needs to redirect its
> RX to the physical device. This patch adds that redirection bpf program
> and teaches the harness to install it.
> 
> Add primary_rx_redirect=False parameter to NetDrvContEnv.__init__().
> When enabled, _attach_primary_rx_redirect_bpf() attaches a new BPF TC
> program (nk_primary_rx_redirect.bpf.c) to the primary (host-side) netkit
> interface. The program redirects non-ICMPv6 IPv6 packets to the physical
> NIC via bpf_redirect_neigh(), with the physical ifindex configured via
> the .bss map. ICMPv6 is left on the host's netkit primary so IPv6
> neighbor discovery still work locally.
> 
> Extract _find_bss_map_id() from _attach_bpf() into a reusable helper so
> other BPF attachment methods can use it.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

