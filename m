Return-Path: <netdev+bounces-97141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842D28C95D4
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 20:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400F1280E09
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 18:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939C96CDBA;
	Sun, 19 May 2024 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="b8Lr/Kk/"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D596E5E8
	for <netdev@vger.kernel.org>; Sun, 19 May 2024 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716143838; cv=none; b=VJ4vG8BSuZ8Uh1imygT1/1SpsBiaAzirnG4rZMKU1FzMRfjveRNcbNrME0C7FI++Eh4+xA8O4CXD4sIpHylBdLInPiv4rP8u/PR0c4jYTyYH4mm5xnEwnOGN2sjnUXkKLw7ZS1pZ6v/iJtos1YLbmATRMUQ66GtkC0iNq7NP5pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716143838; c=relaxed/simple;
	bh=gZMUg4bhcxtMLnD9sH9vFjnhOtG2Ny1HBWxlIbVOWHE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqEHKUCxscaQ2ghdU6RaYwp9BxXIxCKFnryNEihK/9YT9TjnXJ0osYq+oC6CxHi/udnCXNriyLBKvBgloiQN+MWkoEvkU4qO6raS6ogbkP+RYZl1iuaE1RwZvWoKS2wcRdHFO/ie9yn5iTcHLXU5sDEpDSTKz2HotEnwq//SRD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=b8Lr/Kk/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5F89F201AE;
	Sun, 19 May 2024 20:37:13 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VatT-CQOwkgu; Sun, 19 May 2024 20:37:12 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id CCE9420185;
	Sun, 19 May 2024 20:37:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com CCE9420185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1716143832;
	bh=cZGOlSzeKUfNzqL5QabyNUve75ghZ4lS3PXVGTgvtAw=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=b8Lr/Kk/1KNd9vg0yjw3/num2JI7423iVTjCKqYi0/lqonVY3MbisJr7gE8k6MzU6
	 z98aZJ+TQNCfFqmnVidBFBitqef4/TL9+FHqwCCwcFpaLKG/xuiVRGCCks4AR9t4IO
	 w5KEzCV1pelvcSm4QBfX4qpzA+0p/fzYjkt4ZrWfGgAe6ybDjSN3YyqBLJNrfF8SPC
	 lEo42rNYn++9iQFPzxmn2BOpL7mfWkVtYBIZXUZT+dc7bnqdHvqSEmEiPtrwT51RkP
	 RhwK6xi3bdr9u8NSF232bnfW7BfmQ8XZPcFFmtCFZuYc/hdfnDLazQQaLq2lpAhV3+
	 BN9TDsnmNMxbA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id C09DE80004A;
	Sun, 19 May 2024 20:37:12 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:37:12 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 19 May
 2024 20:37:12 +0200
Date: Sun, 19 May 2024 20:37:04 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Stephen Hemminger <stephen@networkplumber.org>, David Ahern
	<dsahern@gmail.com>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, Eyal Birger <eyal.birger@gmail.com>, "Antony
 Antony" <antony.antony@secunet.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>, "Christian
 Hopps" <chopps@chopps.org>
Subject: [PATCH RFC iproute2-next 1/3] uapi: Update kernel headers xfrm.h
Message-ID: <f4e27d8297dddec1af62812374688659809509ae.1716143499.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1716143499.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1716143499.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Import xfrm.h due to new dependency.

179a6f5df8da ("Merge tag 'ipsec-next-2024-05-03' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next")

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/uapi/linux/xfrm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index 43efaeca..dccfd437 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -141,6 +141,11 @@ enum {
 	XFRM_POLICY_MAX	= 3
 };
 
+enum xfrm_sa_dir {
+	XFRM_SA_DIR_IN	= 1,
+	XFRM_SA_DIR_OUT = 2
+};
+
 enum {
 	XFRM_SHARE_ANY,		/* No limitations */
 	XFRM_SHARE_SESSION,	/* For this session only */
@@ -315,6 +320,7 @@ enum xfrm_attr_type_t {
 	XFRMA_SET_MARK_MASK,	/* __u32 */
 	XFRMA_IF_ID,		/* __u32 */
 	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
+	XFRMA_SA_DIR,		/* __u8 */
 	__XFRMA_MAX
 
 #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
-- 
2.30.2


