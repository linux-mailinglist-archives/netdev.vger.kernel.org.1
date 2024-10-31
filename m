Return-Path: <netdev+bounces-140766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A78F9B7F12
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E24E1C20897
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CBB132120;
	Thu, 31 Oct 2024 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBRx3Vwa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531D6A019
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389957; cv=none; b=Oj0qANY9FiiurXLamQHaMwDYw7YJbTScUlHpY4U5VTbnd5VguxDPWNsKNc5A9n4AAswbiE6n6FmMAg+KT2IL2g4zChC8zu212h24kvb/MIFnHOWHfRBQMAoesuhJ0AmIQOZuQRZa2qhEVxl1+AfkEXNfE++GqfbYPq69a619iww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389957; c=relaxed/simple;
	bh=uuAuLlMTOpkOcLpboI6ShhQu4pnmOlSkA5KYphvvyYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZEyUuP1S7rd3hWdNduAPGl7CRDXoZLp/UGKMDmiCneoKBiVCIzYDPeuvVUPL3yCGHZleZQiFSCOXVNtiSwuGD+aQraWwdpSoVtAxKE/4JufI9nTBraUVHBAms8AG87HyIoBvEGDIiJHpwzI+O35moCpohHuhPX4bRDchSD/iWT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBRx3Vwa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730389954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=yhCVDdb+wtldpW2RVaCaLGz9ZFIQRFniD3V7WJZv/B0=;
	b=FBRx3Vwaqq8CAInxdDJOQg43OYSbg/pLDDUIukhA/cFYTV+EdVj5bZGeSbwZVda6C5Csyf
	JHAalVZxUQu4dyXOC6OUhxLjTS3+yiMogc3hgomrVm3ID/dMABXFKjs+z3I3pu6HQBRKKB
	C4XYHVomulzhSpZ3vkQBKEHKsWxxhDY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-FuzSlLSfOQmXkNx3Neud9Q-1; Thu, 31 Oct 2024 11:52:33 -0400
X-MC-Unique: FuzSlLSfOQmXkNx3Neud9Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d49887a2cso620815f8f.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 08:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730389952; x=1730994752;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhCVDdb+wtldpW2RVaCaLGz9ZFIQRFniD3V7WJZv/B0=;
        b=Sy8LaXbZAVm4rhBaj2Peec9+0mpDelFz23XFky58pqkpeIMt8/a7Tck7FQAf4vupp5
         ep0+0olvr75uYIVM0v2LtQyFH56gZ+7LwjxXnZ+x5TK7D/w2CJlndscDwj8KpOJAa9eI
         rh0v0JK10lT0A1dOoDdyyxurPMnOlgtQqUYo+V3MZaxfR8RJdgVEBWIpL1fu8HMr+U70
         A0YKOCu5JRuujyvXYcdD/HJ+hfTCAFM2JGCpFbVM42c2J+187HlydolHCHlsLxioiQxV
         UDEp9CrVJXLPqtB9D9NVuiz3TlqcglhEGUPpbE1nMKWudkkW9BOgaErdaKAAlXyPcBg+
         Fr4g==
X-Gm-Message-State: AOJu0Yya1pOj89NtOKqDGcivDcqWuGk+WFOHPsHsPfxlp6E8NFwRVHQF
	Xeq3Iw0VBLyBUu5T3HdT+kbHFhsB0ESMsubpScd85GfBq3MvuzwQZYlkVuRSlbgqWbJycQQbH4v
	8F/uZfCdbQw0q5bcyLll+1Q3k4PBMOx8Kcu5kVJ2opftYeofxgyBrvw==
X-Received: by 2002:a5d:5f93:0:b0:371:6fc7:d45d with SMTP id ffacd0b85a97d-381c13069b6mr2987750f8f.2.1730389951823;
        Thu, 31 Oct 2024 08:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDCXnGXI43yMs82co7V0rU5NgloR0ZKRDlQhT+UFCQeCUhWhUhX9w96qo5pRrbZaLNR9OLZA==
X-Received: by 2002:a5d:5f93:0:b0:371:6fc7:d45d with SMTP id ffacd0b85a97d-381c13069b6mr2987729f8f.2.1730389951435;
        Thu, 31 Oct 2024 08:52:31 -0700 (PDT)
Received: from debian (2a01cb058918ce002753490a7d66077e.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:2753:490a:7d66:77e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116c13asm2507983f8f.109.2024.10.31.08.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:52:30 -0700 (PDT)
Date: Thu, 31 Oct 2024 16:52:27 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH ipsec-next v2 0/4] xfrm: Convert __xfrm4_dst_lookup() and its
 callers to dscp_t.
Message-ID: <cover.1730387416.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch series continues to prepare users of ->flowi4_tos to a
future conversion of this field (__u8 to dscp_t). This time, we convert
__xfrm4_dst_lookup() and its call chain.

The objective is to eventually make all users of ->flowi4_tos use a
dscp_t value. Making ->flowi4_tos a dscp_t field will help avoiding
regressions where ECN bits are erroneously interpreted as DSCP bits.

Changes since v1:
  * Rebase on top of ipsec-next. Now we don't convert the ->dst_lookup()
    callback handlers since they they don't have any "tos" parameter
    anymore. Therefore, the original patches 4, 5 and 6 are dropped and
    replaced with the new patch 4, which just converts the "tos" field
    in struct xfrm_dst_lookup_params.

Guillaume Nault (4):
  xfrm: Convert xfrm_get_tos() to dscp_t.
  xfrm: Convert xfrm_bundle_create() to dscp_t.
  xfrm: Convert xfrm_dst_lookup() to dscp_t.
  xfrm: Convert struct xfrm_dst_lookup_params -> tos to dscp_t.

 include/net/xfrm.h      |  3 ++-
 net/ipv4/xfrm4_policy.c |  3 ++-
 net/xfrm/xfrm_policy.c  | 16 ++++++++--------
 3 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.39.2


