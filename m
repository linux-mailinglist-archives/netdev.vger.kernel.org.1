Return-Path: <netdev+bounces-280214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eABKATfB52l4AQIAu9opvQ
	(envelope-from <netdev+bounces-280214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:25:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B837D43EA5C
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6295430824EB
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE9136DA08;
	Tue, 21 Apr 2026 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJoelv2H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D778536AB54
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795695; cv=none; b=jgxk0e+XCSWQpA0ZASa/o1K92s2LAkotJcIffrXa0T/E0UAwzIQeNV705J2OI7EVOCzhC+Nffy/Bz8s0w36xrFUzvXpW6eOvpp0PAg9rkfEsfdiYl+cq4DsTnsjJ8j+JFD4ZFNnjmHuA+b6aSYAxD2FIqIqSTmy7gAJA/oPuHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795695; c=relaxed/simple;
	bh=aQmfxg7NQpvGz9XaY5eGgk1AWvqY2YAH6p7UeRcAVIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+ZfbgQDyjcCCOPkeBDD3DiBZ2JeNttHxTaDfIDV/31qfeiXdEBQE3MajG26dwlddaMJpAb+aClmiyt6LXYXz6Bsx6yI09FH/bRE33N06V2oH7DI/upJFQymYHVBjrMxNMFzVZWMs8mKoWBaPU0kzv1WTSJecTvpJSqXwzJXX9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJoelv2H; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43eb05b1875so2705438f8f.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795680; x=1777400480; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ey1/flgNoHl/BMtWwmVozPsjz6fm2TXt8LsvNUUYd8c=;
        b=oJoelv2HHEVJnzn6fnmH8P6XhUL/qLzKdzJeg6fPIWUdz6xtf0A5UPHXH7BgykZZFK
         HggTElADNEdJUN4i26O5eM8XYGcDjFL/h9O1xMVnY9LxgCEaE+DfFJpAupdt+1Ikhpi8
         hq9TwZXNbtTPmy43l90iDTsnIHhPd8oNVCJlZ9HiX8G/fdVzdDei+99m+CPs3osyozgm
         2Wkxe973kQKDxlImQoVSyH5PWiWMBz3C5UPAXytBSqwQG48DBy6biM4+lJmcW6xg8T2w
         UKf6VX7CoXsVf77AdZWJGSfDQczxxPaEug4OdKrNboaRt3SGnXfF1mAts6d2MOC6rDn3
         4W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795680; x=1777400480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ey1/flgNoHl/BMtWwmVozPsjz6fm2TXt8LsvNUUYd8c=;
        b=raAgZtC8vz4ODqdU+oXcW75ZAGYLKmgRpSn++xegX5REZ8sry0Gn6hBx0NiJz6+2tB
         Tkt9wSpC0vbbaTWuQGvhzyhZbRsyh5VdVE7t2woMe+Fhy6A3qBwoAmPa8sbU0tQHj46Z
         xiULxILsQLhClIKVyaWKEFc+WmcKIoTrt2OVff1Oq62xllG3Jc1oUUA1EoJQJ3n0RwRa
         cHAUiKpy41GZQoxyjikpPHGWMT1ZJZ35Oh5IXyGiBl9AA0S40BJtIOCrHDFxxXowa1Wy
         dGVH4qCX5fZWHooh29IGuYDhNYX/2gVqeAj9DMHcA5JRwQ0iS5andlSW8wHQF99hnh4G
         a2pw==
X-Forwarded-Encrypted: i=1; AFNElJ/qY4GzortAho3R//GHHEnaV8D3kc+7sSDVi01688kSzcaPXvXYcMnXlHpwAh6I6PfeEEnqXIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbREclqOOYgmYCseBBWEWOXrBGfn5PKVNypXHqHEfS15rJvMwA
	v6bfsRGztUO2ygjY5OHdZ7cepJq6YsLiBjWK/reTix1MVYqPXYZC56nq
X-Gm-Gg: AeBDietai4Ve3LMPM4Q2jVyQQDMiioYJMOvPoXENkZEFq35Gru/J1PO9jYMg5G1mYI+
	cRrjyVV0k4wu+JrdrJ1/tSUmeICIllqgUZUZov5ZYnGu0VmCL1lg+fIuICJZaua6/AZ8RV+Yy7Y
	T5qAR0N69nn8clqle7VlZLbHdAo2akQasGUyDBax8AUWEd+tqJl1hIj9+J/WagHxNsEpyZmsaPM
	oC2hZrAvVwqtZeXK5tjPRdhmbal2to9NHPwae6p/haobsVgd3M3ZKwFBBczVXjqK7fRQUEen+qA
	BjHiXBqku2DuQLpVmXhB8kaqjR7r5ut+Lr38SFhL5Q1OlGxzH2x0PKKlzU3OHBJEnf3vhS//mb2
	ci1Qs5VgHIajtuFfoP0Bi4M9iiu2Q1udbAKQGAwgUqgI9WhKSpsnM2dmQJzGq/j9hWCSrr5Caek
	kSiG7quNFahXhkJstVNbYAaKc5dKgESmlFlgkWQe2yyVnkfx1ScFAS/wo+SEChNZ10Ctixt8EdW
	A0Y3yumQw0YO0oD+qcl73y0tOum4iIfMHEnRQ9mIcZkKhdVJFVbr59LutEo4axtjX7tCw/Sclc4
	pWxZENp5b5OmR4sjnjeDn2ib0lo1ny4nVvT33EuqZ0akblBcJYTWDA==
X-Received: by 2002:a05:6000:2082:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-4411c18f7c5mr10736741f8f.37.1776795680060;
        Tue, 21 Apr 2026 11:21:20 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0026dd69ace0c02e6e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:26dd:69ac:e0c0:2e6e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1365sm41235025f8f.7.2026.04.21.11.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:21:19 -0700 (PDT)
Date: Tue, 21 Apr 2026 20:21:16 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Alexis =?iso-8859-1?Q?Lothor=E9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, ebpf@linuxfoundation.org,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: drop xdping tool
Message-ID: <aefAHLdVZaOmf1Os@mail.gmail.com>
References: <20260417-xdping-v1-1-9b0ce0e7adf8@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417-xdping-v1-1-9b0ce0e7adf8@bootlin.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,iogearbox.net,linux.dev,davemloft.net,fomichev.me,linuxfoundation.org,bootlin.com,vger.kernel.org,oracle.com];
	TAGGED_FROM(0.00)[bounces-280214-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: B837D43EA5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 05:33:02PM +0200, Alexis Lothoré (eBPF Foundation) wrote:
> As part of a larger cleanup effort in the bpf selftests directory,
> tests and scripts are either being converted to the test_progs framework
> (so they are executed automatically in bpf CI), or removed if not
> relevant for such integration.
> 
> The test_xdping.sh script (with the associated xdping.c) acts as a RTT
> measurement tool, by attaching two small xdp programs to two interfaces.
> Converting this test to test_progs may not make much sense:
> - RTT measurement does not really fit in the scope of a functional test,
>   this is rather about measuring some performance level.
> - there are other existing tests in test_progs that actively validate
>   XDP features like program attachment, return value processing, packet
>   modification, etc
> 
> Drop test_xdping.sh and the corresponding xdping.c userspace part. Keep
> the ebpf part (xdping_kern.c), as it is used by another test integrated
> in test_progs (btf_dump)

The xdping_kern object file is just used in bpf_dump to check we can
parse the license as expected. You can replace that by any other test
with a GPL license (ex., btf_type_tag_percpu.bpf.o) and remove
xdping_kern.c.

[...]


