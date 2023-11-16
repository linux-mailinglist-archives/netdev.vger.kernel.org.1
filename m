Return-Path: <netdev+bounces-48426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F687EE4E3
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997181C208A3
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC756321BE;
	Thu, 16 Nov 2023 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="LuqcYZvl"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D20181
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:02:17 -0800 (PST)
X-KPN-MessageId: 6d7a2186-8499-11ee-8344-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6d7a2186-8499-11ee-8344-005056ab378f;
	Thu, 16 Nov 2023 17:01:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=BZcbp0EtpK+gcvR4kYPjDNzhEWpkh11PDJMBB2ZktYI=;
	b=LuqcYZvlCd5b0oGH2hHM+NU4mQXnwTJZKkL4hyD+q5prwmbrBmtfvzoZDQsaJpPwlc53tNfaWoMhU
	 ZO6AwdYaRpKFPZFbWW8BDrPYPI8y1CkRgGDvbwdJcSc8mSdy7VjNp8lCssr+Yzd0iirXzjxvPpEmb4
	 IKw634KsY9KgdyoE=
X-KPN-MID: 33|5qHtF0KFz/0RtbOIKpiiN6hGVFYHi8KWV0CT7qtwdlg04D+Sd04ZokGv2RUvAe1
 G9BqnqktXoJj/oQ5pWhlQHJxIYgphRRIYj6DHjT2eBgw=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|DXsEZD6/oHM9Jty9oqnubccBqIlG2y/BRbMN/3aGP2RW7v539EgDIur8Taod4A2
 c1H629s2EH6wMfbARW0nekw==
X-Originating-IP: 213.10.186.43
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 822ee438-8499-11ee-b971-005056abf0db;
	Thu, 16 Nov 2023 17:02:15 +0100 (CET)
Date: Thu, 16 Nov 2023 17:02:14 +0100
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, netdev@vger.kernel.org,
	Christian Hopps <chopps@labn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [devel-ipsec] [RFC ipsec-next v2 0/8] Add IP-TFS mode to xfrm
Message-ID: <ZVY9Bh5lKEqQCBrc@Antony2201.local>
References: <20231113035219.920136-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hWne0x61GuDSD4vR"
Content-Disposition: inline
In-Reply-To: <20231113035219.920136-1-chopps@chopps.org>
X-Spam-Level: *


--hWne0x61GuDSD4vR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 12, 2023 at 10:52:11PM -0500, Christian Hopps via Devel wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
> (AggFrag encapsulation) has been standardized in RFC9347.
> 
> Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> 
> This feature supports demand driven (i.e., non-constant send rate) IP-TFS to
> take advantage of the AGGFRAG ESP payload encapsulation. This payload type
> supports aggregation and fragmentation of the inner IP packet stream which in
> turn yields higher small-packet bandwidth as well as reducing MTU/PMTU issues.
> Congestion control is unimplementated as the send rate is demand driven rather
> than constant.
> 
> In order to allow loading this fucntionality as a module a set of callbacks
> xfrm_mode_cbs has been added to xfrm as well.

Hi Chris,

I have further reviewed the code and have a few minor questions, mainly 
related to handling of XFRM_MODE_IPTFS. It appears to me be either some case  
missing support or/and in a few places it should be prohibited. I have three 
types of questions:

1. missing XFRM_MODE_IPTFS support?
2. Will XFRM_MODE_IPTFS be supported this combination?
3. Should be prohibited combination with XFRM_MODE_IPTFS 

1.  Missing:  

a.  wouldn't xfrm_sa_len() need extending? 

I could not find support for XFRM_MODE_IPTFS explicitly.

However, I'm not sure how the following code is working when xfrm_sa_len is 
missing IP-TFS xfrm_sa_len:

copy_to_user_state_extra() {
    if (x->mode_cbs && x->mode_cbs->copy_to_user)
        ret = x->mode_cbs->copy_to_user(x, skb);
}

I have attached what I imagine is a fix. Check with Steffen or others if 
this is necessary.

b. esp6_init_state() and esp_init_state():
These functions do not seem to handle XFRM_MODE_IPTFS. Would they default to work with it?

2. Would xfrm4_outer_mode_gso_segment() xfrm6_outer_mode_gso_segment(): 
support XFRM_MODE_IPTFS?
These functions appear to be missing. Is it possible that you don't support GSO and GRO?

3: Shouldn't these combinations return error?

a. ipcomp and  XFRM_MODE_IPTFS
I'm guessing that ipcomp would generate an error when userspace tries to add an SA with XFRM_MODE_IPTFS.
ipcomp6_init_state()
ipcomp4_init_state()

b: In xfrm_state_construct():

if (attrs[XFRMA_TFCPAD])
    x->tfcpad = nla_get_u32(attrs[XFRMA_TFCPAD]);

-antony

--hWne0x61GuDSD4vR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-xfrm-iptfs-extend-xfrm_sa_len.patch"

From 3d9ad9fab35f4efd6c2fb17853aaca986e7daaf3 Mon Sep 17 00:00:00 2001
From: Antony Antony <antony.antony@secunet.com>
Date: Thu, 16 Nov 2023 16:46:54 +0100
Subject: [PATCH] xfrm: iptfs extend xfrm_sa_len

think this extension is necessary. I wonder how it works now:)
May it is alreday handled:)

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/net/xfrm.h    |  1 +
 net/xfrm/xfrm_iptfs.c | 18 ++++++++++++++++++
 net/xfrm/xfrm_user.c  |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 176ab5ac436e..7ca508b0c46c 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -474,6 +474,7 @@ struct xfrm_mode_cbs {
 	 *    mac_header should point at protocol/nexthdr of the outer IP
 	 */
 	int	(*prepare_output)(struct xfrm_state *x, struct sk_buff *skb);
+	unsigned int (*xfrm_sa_len)(const struct xfrm_state *x);
 };
 
 int xfrm_register_mode_cbs(u8 mode, const struct xfrm_mode_cbs *mode_cbs);
diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 910c5e060931..d8b02cc3073b 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2613,6 +2613,23 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
 	return ret;
 }
 
+static unsigned int iptfs_xfrm_sa_len(const struct xfrm_state *x)
+{
+	struct xfrm_iptfs_data *xtfs = x->mode_data;
+        struct xfrm_iptfs_config *xc = &xtfs->cfg;
+	unsigned int l = 0;
+
+	if (xc->dont_frag)
+		l += nla_total_size(sizeof(xc->reorder_win_size));
+	l += nla_total_size(sizeof(xc->reorder_win_size));
+	l += nla_total_size(sizeof(xc->pkt_size));
+	l += nla_total_size(sizeof(xc->max_queue_size));
+	l += nla_total_size(sizeof(xc->drop_time_us));
+	l += nla_total_size(sizeof(xc->init_delay_us));
+
+	return l;
+}
+
 static int iptfs_create_state(struct xfrm_state *x)
 {
 	struct xfrm_iptfs_data *xtfs;
@@ -2701,6 +2718,7 @@ static const struct xfrm_mode_cbs iptfs_mode_cbs = {
 	.input = iptfs_input,
 	.output = iptfs_output_collect,
 	.prepare_output = iptfs_prepare_output,
+	.xfrm_sa_len = iptfs_xfrm_sa_len,
 };
 
 static int __init xfrm_iptfs_init(void)
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 4b0e462d5e31..737636b2c267 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3350,6 +3350,9 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 	if (x->mapping_maxage)
 		l += nla_total_size(sizeof(x->mapping_maxage));
 
+	if (x->mode_cbs && x->mode_cbs->copy_to_user)
+                l += x->mode_cbs->xfrm_sa_len(x);
+
 	return l;
 }
 
-- 
2.42.0


--hWne0x61GuDSD4vR--

