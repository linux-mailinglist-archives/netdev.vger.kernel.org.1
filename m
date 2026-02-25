Return-Path: <netdev+bounces-261021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHQwJzQfn2lcZAQAu9opvQ
	(envelope-from <netdev+bounces-261021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:11:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C719A4B2
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C47B431C7481
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B48A3DA7CB;
	Wed, 25 Feb 2026 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGDskJud"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA13DA7D8
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034314; cv=none; b=tsvWmzxHBLx7vgrKjyi38gjC8vv1iHtnIRHhZ8wDh3+WD4Oy1VMC1QS+c7dkic3D3xszj55tKKd/o2wgTjpigkC3W8ZgsJSbRr2ZeK3vmYLL2CnXnqYU87b/A33wjHJxelsXib8V+ac6s5FZtbTFAXEN3k9OdTsm7OX4XcauSqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034314; c=relaxed/simple;
	bh=gPvFcEfXiqPuy7lYBnMUvduvXgSEpCGhKTVWVx2/xH4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iNUSRlXUy379/aE0j/6O1D/Pzb712VqZuVKzTB7YEbWAhTigfpR1+cl2pn9imvlMLQMP2N0jInpYjNu/G8rIS/m/mkY5KlKn2q2N8TWLxj1h3lNpK4QdST7nrqZ9u3Z1EEo1OF1eVoaiQmKEsYLiPLJJakmrw3ftWiARwBpBXYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGDskJud; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-798527f822cso32817767b3.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 07:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772034312; x=1772639112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uO65KSWBr0mQ6tb0/2KN58uTscIuAO7gxPT58NJtVsw=;
        b=eGDskJudULKb/RUybAan/2Ryee8o0N11aDPibQUfrc9YGkz/71ZBZTqdyYUvyLokoE
         MtVLmwz2KoHoXbwumeTFJe2VroVsRQHeqbSkV227hLYQr7fBMaYd6GFVZmccAWV95aSN
         VT2Czwc6ZCrtb8gDL3y8oDfRemKfUnbNN4Uq0wn5uybtnyJWThAIyMRN350xWD66OHqg
         jiTrTciICrM/tl1e0Oep2PvQWr3dQ1qC4mS5SD7l4Aq1sSaSDFdZBKhyDWsSUNJMKXgQ
         FAIjJzvqhbiAH4KuUG7B5hGBBROn/EMpRP9Luue0YJx1kkF/1oDTPSRPpQTQcSwUsGna
         5bgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772034312; x=1772639112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uO65KSWBr0mQ6tb0/2KN58uTscIuAO7gxPT58NJtVsw=;
        b=RxZC+DqYMZaTdRQsjk3HHzMIO5E4ZihEtm3zDE42ZfZFXdglSKAPs1lF9bCcphbdyk
         I13Rd/iIt4eQr7c2fDMoPQI2pcWPAzqzC47Q0JhapUmfarTdsjdE7LsfyAjzt30305PH
         //cJU+89FhOk+5xIgmwVbhtEAdODQDTc8aje3sbhLfBYbq/m0+tWbicHqADfYjYTZOsa
         AWvJyU6joSkeIXUzU6ewPRlMvwfuQIqF/iAcpOVs3wHURTVmGTkYhOaSAb9o1xSpiB2X
         ZHzqxQ8KoTHkNKFTYuJk67a21YK/744tlkqWpqRRF19Lrc7tSUTPrijfG6kcFkB/EesK
         OvsA==
X-Forwarded-Encrypted: i=1; AJvYcCVSP9qJVGX4nBupc9knA4ZtfUGFFag18H0KOPXMPsnoivr2TWsMzuKlTkqDY5hk86B/ofJ4ccI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLkrIQo1/qq3jSUmZPTlHmfPc/Tw9QSamq9xuMPoGO1ySxAWMX
	6QORuaIwvGLxoY6PiKkdO/V03DnXSgQ68YLBvBuIJ+DvTHZ/5y4qcB2A
X-Gm-Gg: ATEYQzx4GezRLUTw+Z93mbuTYXPZPVMvRRzKqUW1oj7sDlkPomXP12fmay1t1toVNFo
	dORB0RGzlhu9Z6tTq9Qkap00YmqMbnzRaWlqO1b1N/ucSAv3/awYTmrnD3NBcRAL8UTgcBK1BS6
	YoxCyYlFt4vetOttAEXcz3zNZ2D2Bvb9DNxzTz4OV/ZZ8H2tXFVpKI6SC2DAV4kxbGODB+iRXPr
	tDlRd4iAJP95/nT0/GwfGgkIBbQ8suQzEUZn2BN7sl/WFFP97mrFlUmabZione/egeqHjsp35x7
	DZqRQibtbQAxaLSGELaOyoopiOme4ZOnfh/Z7dmBg1F9e2px02dfNiPwPqCl4XvO7hhuwFJigYA
	hHU9ciXGnuvOiM9tn3RWCJDCHX4wRQXYg8v/a/OWW1/FAD2cZgY9ruMqoBK07LQwk8YJnbai+mk
	3SummWldQUHvNBqJRdlTH/15cCHJ65k7NEhk3UvAmPj11Y1+rf7G/RPZ4fiZiza2s9hQuyiAUgM
	HiagR25Gg==
X-Received: by 2002:a05:690c:6010:b0:796:3079:ab9 with SMTP id 00721157ae682-7986fca012dmr7700337b3.23.1772034311854;
        Wed, 25 Feb 2026 07:45:11 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79868dc683csm8102117b3.3.2026.02.25.07.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 07:45:10 -0800 (PST)
Date: Wed, 25 Feb 2026 10:45:09 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Hudson, Nick" <nhudson@akamai.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "Glasgall, Anna" <aglasgal@akamai.com>, 
 "Tottenham, Max" <mtottenh@akamai.com>, 
 "Hunt, Joshua" <johunt@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Paul Chaignon <paul.chaignon@gmail.com>, 
 Mykyta Yatsenko <yatsenko@meta.com>, 
 Tao Chen <chen.dylane@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, 
 Tobias Klauser <tklauser@distanz.ch>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.7c6e5a81afba@gmail.com>
In-Reply-To: <7C8018C7-B0E2-435F-B155-60F29BCF5018@akamai.com>
References: <20260219104710.1490304-1-nhudson@akamai.com>
 <20260219104710.1490304-2-nhudson@akamai.com>
 <willemdebruijn.kernel.5766d0a10c73@gmail.com>
 <7C8018C7-B0E2-435F-B155-60F29BCF5018@akamai.com>
Subject: Re: [RFC PATCH 1/1] bpf: Add tunnel decapsulation and GSO state
 updates per new flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261021-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[akamai.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,meta.com,distanz.ch,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 191C719A4B2
X-Rspamd-Action: no action

Hudson, Nick wrote:
> =

> =

> > On 20 Feb 2026, at 21:08, Willem de Bruijn <willemdebruijn.kernel@gma=
il.com> wrote:
> > =

> > !-------------------------------------------------------------------|=

> >  This Message Is From an External Sender
> >  This message came from outside your organization.
> > |-------------------------------------------------------------------!=

> > =

> > Nick Hudson wrote:
> >> Enable BPF programs to properly handle GSO state when decapsulating
> >> tunneled packets by adding selective GSO flag clearing and a trusted=

> >> mode for GSO handling.
> >> =

> >> New decapsulation flags:
> >> =

> >> - BPF_F_ADJ_ROOM_DECAP_L4_UDP: Clear UDP tunnel GSO flags
> >>  (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM)
> >> - BPF_F_ADJ_ROOM_DECAP_L4_GRE: Clear GRE tunnel GSO flags
> >>  (SKB_GSO_GRE, SKB_GSO_GRE_CSUM)
> >> - BPF_F_ADJ_ROOM_DECAP_IPXIP4: Clear SKB_GSO_IPXIP4 flag for
> >>  IPv4-in-IPv4 (IPIP) and IPv6-in-IPv4 (SIT) tunnels
> >> - BPF_F_ADJ_ROOM_DECAP_IPXIP6: Clear SKB_GSO_IPXIP6 flag for
> >>  IPv6-in-IPv6 and IPv4-in-IPv6 tunnels
> >> - BPF_F_ADJ_ROOM_NO_DODGY: Preserve gso_segs and don't set
> >>  SKB_GSO_DODGY when the BPF program is trusted and modifications
> >>  are known to be valid
> >> =

> >> The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
> >> renamed to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
> >> Run Everywhere) lookups in BPF programs.
> >> =

> >> By default, bpf_skb_adjust_room sets SKB_GSO_DODGY and resets
> >> gso_segs to 0, forcing revalidation. The NO_DODGY flag bypasses this=

> >> for trusted programs that guarantee GSO correctness.
> >> =

> >> Usage example (decapsulating UDP tunnel with IPv4 inner packet):
> >>  bpf_skb_adjust_room(skb, -hdr_len, BPF_ADJ_ROOM_NET,
> >>                      BPF_F_ADJ_ROOM_DECAP_L3_IPV4 |
> >>                      BPF_F_ADJ_ROOM_DECAP_L4_UDP);
> > =

> > This patch is doing to much in one patch.
> =

> Sure, I=E2=80=99ll split it up.
> =

> > =

> > Also not convinced of the need for the NO_DODGY flag.
> =

> The reason for NO_DODGY is that, without it, the egress interface will =
see the
> SKB_GSO_DODGY flag. In our use case, we want to avoid marking the egres=
s tap as
> NETIF_F_GSO_ROBUST, so the skb will fail skb_gso_ok() with SKB_GSO_DODG=
Y set.
> When skb_gso_ok() fails, validate_xmit_skb() calls skb_gso_segment().

I understand why you might want it. But the dodgy check has long been
there for a reason: becauses these transformations are not blindly
accepted by the kernel. This use case does not change that.=

