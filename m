Return-Path: <netdev+bounces-297353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6Z8oLiqkKGokHAMAu9opvQ
	(envelope-from <netdev+bounces-297353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:39:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0810664D26
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:39:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=GcJ+PaQl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297353-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297353-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D74D6301B02B
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 23:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790D43EDADA;
	Tue,  9 Jun 2026 23:39:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFE23EDAC1
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 23:39:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048355; cv=fail; b=aEdAJ6Gk86ljEcLwvwz8x25kbGpBjOYkMkFFCbziqlzJPVm+GswRm8Tw4rH0T5zpSMwuOP4XuUNc78+zFEzw6KndnTm6uhKgU3Dr+DtX2b+hhTgisDQwa5oDyfXCbbnLFq/5N6f7QjUBPZakFB9iy7IAgczLTrdHdVx+MEQjyfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048355; c=relaxed/simple;
	bh=GJd2gJZmlAgFMCFkHrHwJ2yIaE6MPUQzzzENfnpUb+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBm+uW5dyA9qXPMmkGspoADXcj7YMeUdN90Mr/LOhSQAFeyVrQOESM6Zcl4dCwt/FJpjnH8SJPyKvDkARBOTbzOZG7btn0hj74/BdL3amZt4zi23xLcijL7xGj4Cw7oj4mknpdv4asywEDrdWwZgDmcMBfcm+KTIAgN7deZNRNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GcJ+PaQl; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659HkYWV3131380
	for <netdev@vger.kernel.org>; Tue, 9 Jun 2026 16:39:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GJd2gJZmlAgFMCFkHrHwJ2yIaE6MPUQzzzENfnpUb+A=; b=GcJ+PaQlVJQW
	/QiaOOTC0nYPA6Pp1uWg5Nw0lxfOPK46wy3QRjqt6HHI/s8hYflLqOpkQeAGxxLh
	hoyKhwGK2JX4YooWC50qu5EDWSMax2nyL/oD/rrE9huRAKUD3dcFOCQPD6EbqIBe
	/w0OyjcqD5OfnfePJGKHwyaQUFmf3+Tzo3fYXQ5XrBU7OcozGO9AnrRjAwvSdxcY
	Crl7znQ4/d1k0Z7Rho184bTWuJJxHxuMZzLmmMtWby4mzLYkfL9hkRHA6cnRmNak
	77cxz9A7UldkmH6wLB52VlDZREdWuq79DRuezb/llSLMmzA0JKqEm6HamQd79ptg
	ldQYgc2yiw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4epqhcj9nj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 16:39:12 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6f01486a0so11913588a34.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 16:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781048352; cv=none;
        d=google.com; s=arc-20240605;
        b=Av5rIBWvfiewQ8jInd1cXhn0j0C5i3KBSYlKVEl6sOmaCU7RiqrofGxXifV5ZD7+zo
         7RN6LvV6jkp74hkSt5aNyMPAMkwuIIOR6qXbVBRUKzZHCDr2R+z2/kNTg6aAci6+eLUI
         dWj9gPrzXstlWPcar2VxhogS+BvV3fo44AwGc5YTPhM8Ly//V/J34VMBCSTcbiFjXdRz
         mWtSXeoeA90S6Bn9EsFtm2Z/uQ8MoriOKtD/3TbSXDEKlLMZ1/rW7Z/TaKKUFEnyfIqg
         Hv4z4G70SG07px2mf7IzhWwvjbPgPFP+bh8irQnLz+IUQoDJKAIWw0PwQu4FrLeyslzF
         avlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=VHRS+sWMPwoxZ0n+tLXpfsQUcezlTBJw4Sj0yHIKfGE=;
        fh=xA/8p7RKjnBb6Vfft7uwmKTWRHOEHWFFKCQUi9ZP+TE=;
        b=jEUOyjnh5TKImq99XX1KeIgpODaPwNUnSqkJItV7ug1xnEiTKMU/FodBxEWfZJZfUx
         4oGV7I8zV5n2yfrx/cbI0v2b3/xhawvJxlEpmohftejyqzks1r4XAIiGWvGW9okxQrFa
         C7ZuzWzrpwr0cAivOZx5HN4Rvl6UqBSgbwrLg1ft2uoA4Ad9xQVqA7OJReaan+IAZI2i
         1NEeNxGznxx2ElyDyskhGImugJqzVPEgxdZwD4vlv3nEAt3B0vVVxPFlbyGPT9IfzU9p
         vTydR5CAqU7wT/GADT/0p2Na4LjBxgrC6TGY6NFmiFiOTpTKSJky53a6VQCuk+gKoIH1
         PQXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781048352; x=1781653152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VHRS+sWMPwoxZ0n+tLXpfsQUcezlTBJw4Sj0yHIKfGE=;
        b=H54QrSpGzVo8qCYcLnr+yU10y7tpOl8/o2QQahk8lWYfBWNaR/h4s/SLQDXk+rvlcR
         Rott6eSsmGIC0o0zbwCDD5SpHyAPw78Rah/cJrqKrMXO/r243jh8DtobBE/i+iiDygkj
         l5LKDZ07qQX0GjjDCxk9QiYUYXLXDoXRt7hJn2cSbvCS+vwmsyNJmoRv81rVClsCrVUb
         Pbf7uW7VAPy4Wr+1c8YuFhCAdhmq8MRf8N+Pa4W/z9KNRabwe/3KMBRS4Z6smTX5gRQO
         etAg9teGU0PwGPiVKGGQ1QyyP4ZQ7sXC3RU8OTTeDHvlQnRsHeyD59VgaBjYxQ38OZAO
         f52g==
X-Forwarded-Encrypted: i=1; AFNElJ+wi5TVLHwhyil3U+Z7qXQ+tWRD1G1wWH7YPgS6LZvW6dNcx3eL9ZdfM58/iu9TfxJPHpPRYnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1+goj7Z6lQC9paxbWGzLS7BkLIzB0cMkRuOT9K/8U0g6kLXTV
	WwJu9pyu/k9Aa6Atm/EyO4Ix+KwcOFdT6txGhbYPLLIkypvVq4w/12x2X7zGg0nXO+sA6ZQKlRS
	2uBAXir3sxwvnphhA30ss510i5CUO/LjyuEbehITv8LKvZoOA2gg3aKaqqMep3+/qgngjJsNMU6
	Zjor0g1cab26uYJQphQtN8vEmwG3UbnOs=
X-Gm-Gg: Acq92OGrm31YBm/ebcPXONnCYnp2zFKQBdmTz+CCpcyhpkve+U3OE9Li1Bh0RTf7yX2
	n7IdjTfCp8XeFcF9UCUbs3/HNkokCb1DFbO5ldBd1m/tSM+ZYGMd/u5p7/jJl3Z/c50aRLyOTOY
	JSD9RDdqD9skGvAb3ha6WTquQPMyD7AjXT8yW6n2UkB+L+FpjpRUf+sbtw61iGGAsoHDXiNbYZJ
	QPSDgY0EvfKzXHOi22LhWfMHVjFng==
X-Received: by 2002:a05:6830:6108:b0:7e5:68d0:462d with SMTP id 46e09a7af769-7e751abe2fdmr3883347a34.19.1781048352093;
        Tue, 09 Jun 2026 16:39:12 -0700 (PDT)
X-Received: by 2002:a05:6830:6108:b0:7e5:68d0:462d with SMTP id
 46e09a7af769-7e751abe2fdmr3883310a34.19.1781048351521; Tue, 09 Jun 2026
 16:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608185646.4085127-3-zhipingz@meta.com> <20260609195612.GA85322@bhelgaas>
In-Reply-To: <20260609195612.GA85322@bhelgaas>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 16:38:59 -0700
X-Gm-Features: AVVi8CfvpQJ6ajVUxnazmY-1cK1d-x3MxGzuw2_lfYAMYCTtvbg2jMZaGu0O5NM
Message-ID: <CAH3zFs0u7qJ9JsfweOw_r0FqNUpixLvawZKp9pUTcWWQN6nZjw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] PCI/TPH: expose enabled requester type and
 capability helpers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: HeJjeyKeZZvRjWm0bZSeh6ut--ItDqfd
X-Authority-Analysis: v=2.4 cv=L4ctheT8 c=1 sm=1 tr=0 ts=6a28a420 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8 a=earV_t7fcAfV2sAEFq0A:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIyNCBTYWx0ZWRfX1rWPJ8wRLAyI
 aVQqRoZiTwD27qQbkbzcE88qVFinAGjKs2klDkDjLdU0YwziAqtdNj8Aldq7ognB4QFNP5kY/Cs
 j1skPEhqoIWwpwdqkMBQdvlQkat/bqFj+HalVfyscG8qTlEU/450NF9/RRE0tNCOMtw5d9ZyZt2
 hOUcXEHefGCW3bAtsUX8uQhzYg7yRUFQ0M9l9enoclOJM+YoZbcXlBOo6uyq7t+90Da/IWbxaPP
 pV0ZEChCpKx6ZiEgY2Rd8pd1purFCkBAP+DztpSQ1jQOMHVWoFE83S4ILYbUlVEUzRjKp8ZJC9S
 b+zBfTWowKAM8vqP/1reAXnpUFRjtnmEd2/0D8ubmNHbPNPx9b3xV7bHX/auU9sUeeG20fnOnl2
 uXQA8PM634NxlVzu70iOSMLsGM4Gxe1eAl70sKyeisVdJQNS+YlhkGR3QE2nWl4p15DvntF3fbT
 rc4W/71c2ylydEbGfUg==
X-Proofpoint-ORIG-GUID: HeJjeyKeZZvRjWm0bZSeh6ut--ItDqfd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-297353-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:helgaas@kernel.org,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0810664D26

On Tue, Jun 9, 2026 at 12:56=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> >
> On Mon, Jun 08, 2026 at 11:56:39AM -0700, Zhiping Zhang wrote:
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals, and
> > pcie_tph_supported() so they can test whether the device exposes the
> > PCIe TPH Extended Capability without doing the same.
>
> s/exposes/advertises/
>

ack, will fix in v7.

> > This keeps pci_dev::tph_req_type and pci_dev::tph_cap inside the
> > PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for callers.
>
> Update subject line to match capitalization of history
> (use "git log --oneline drivers/pci/tph.c")
>
> s/expose/Add/ in subject.
>
> ("Expose" suggests that the interfaces already exist and we're just
> exporting them, but these interfaces didn't exist at all before.)
>

ack, thanks for pointing this out!

> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> With the above,
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>

Thanks,
Zhiping

