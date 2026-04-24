Return-Path: <netdev+bounces-280935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mY3NFwD96mltHAAAu9opvQ
	(envelope-from <netdev+bounces-280935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:17:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B004459E40
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43282300A391
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE8B33A9E8;
	Fri, 24 Apr 2026 05:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg8ekBbk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C391BBBE5
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 05:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777007867; cv=none; b=iGSq42fzBI20uY9LgE2bd0rmLAw8fpV0kOijbC55N7UoxUIyma0oyBHjRqBBmN4+OOBprqH8CubJ/Jm60slGGvn6+hVtAHWiIgd//svafz7hJJj+ycUKcjL8K/jtAG7r4R/aQoefP0HfpEOs7CwW/MqSFtBnOcXzM2rIQXGbyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777007867; c=relaxed/simple;
	bh=cy+jfZevRl4qnhUm8i+XX7pD88aruLbn13jduBtEK9A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HRuTtbFoko9W++GJZv5JrLQsqN0CR1j+uj50b5QCfkRYcpV0oKD90uCS2cAtaBWTZqhe1NuttldK11CON5sLSf/3vKfLsExizcKtEAUbLD8Cr/YNAcp1Oi9XlMJSzDT7TzjA4EBd57v+i5rAhCXfGLg6WPuCAz+1dJbwUvF1Rho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cg8ekBbk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso4450852f8f.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777007864; x=1777612664; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CmJCiO+yYPwYPiaZsf/z2HrFYMaHB6ygscvb77nduZw=;
        b=cg8ekBbke8nLR/dTyiTx0wOeHvkvRy8LEMx10KCPHZhaZBpuUCc8O7CbmwOrg3O1Bn
         vR3TasWpwFCGavVNuy9DgYXq26+AutWxLFpbd5l7TD6u3wsSQAJ9FcVR9HlwttjOqtuC
         1L2dDCsh5ev3zhtaRpC6+HWFUqWWTFcx2W+fzQWP/P9EQBBhUU0uaWrmbrdJn37jMeTw
         h/bP+4h2PRShhxg69DOWdaLABVaTWSN6TbtbtdquEbrOgTmPQeyeqVmxfmY0e5kiwz/V
         237z7drNldS74xi4R4v6lPt5Lv8+YnPAzVRoSt9+heEUXOszsMze5Q9GoXFk45pjd7wm
         3kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777007864; x=1777612664;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmJCiO+yYPwYPiaZsf/z2HrFYMaHB6ygscvb77nduZw=;
        b=F7rjDZfCi4IPb4oN3tSiewe/LAOKjiMfr/vfN03df74APFwoqZHE1QfF3o7o+zN9MD
         urMudQU9gHn4NYIBO0CNu0uZVZ8tZsRNNDj0kuMgmm8aaXljlwKEPL7Plb5Ziqvv+yFM
         SR5lwBUaiNRxBTsJLe7IAGzmZqxmrndYOlZBtai2gYKa7tGGr7RUF4B4YSl8il0p8/SG
         XYCt1W2adx3HzkIska/cEjRnJEJjai8DQWnDag7ZyKD19S3GqwUGKhu0i5ikitpGDW7o
         eKXK4Jx/y264B8/vWYz1QN9/DI0uGmWgM5nqm5h4tdTec8n7ltD3mNOVGLsHvTDhc502
         PeQg==
X-Forwarded-Encrypted: i=1; AFNElJ8cZhpW2UKfC73pg9yA7xWQWjpvaYbbuJDGGTTeUSlGVQrZhW8w4JVMofOieafvtl3Rdm2SKhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YytqAHbYUYG4YBC5eDJ6gozfqlDJMbkKz6Lmss0PFCyCOpi2qn1
	Ahp1Wwi5JMoR0ORfxev6gPnOPHKseGmsjIXe0nMW7w2GQYTISc6woSe7JXXicI+vMUc=
X-Gm-Gg: AeBDieuo8SjgCYSif6C+bBnQnLYyCDqtfiON6txsvhJ2q/cpbW2Lx5xZrsbAQV3dKMN
	U1NU7s1R9BjpC9M6Zne4Q9mnDTCIqhehcNZMStsNxSiSx+XQEC0adK3kq3pf7Uw5w0516WN6XsI
	fmHuSZQM5km+BljPUtfiiDAVcKOPDMeU8MYRYVKyFK/anQ0K+KHT38zLsu/gO/1uixvOpFAvdSJ
	Umd8V/AIgscU3EqRLmn2deF0kQN4qzEhBQ/LFjqhK9YWsh0sKVRIG8oDPAoNIrGaXyyatTkpSmV
	07f6QeFug48sl9l6VOCFBiwoOWzL+WAFerr48cO5uc7hVTTBmfbNe5OWcyLqBxOZ/WoQ0dKbZFr
	jDKTdAvulg4CahNu4mTSwFdOBclftX7Hfm2dLLFfCnieThH+YpI0+YZigifPjwCZcFa9Dg3QGEi
	3yLbgrc9aS4B+C9FncNnzXg7AoJobzgQ==
X-Received: by 2002:a05:6000:184d:b0:43d:e31:68d1 with SMTP id ffacd0b85a97d-43fe3dd958amr47249130f8f.21.1777007864389;
        Thu, 23 Apr 2026 22:17:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1365sm61414871f8f.7.2026.04.23.22.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:17:43 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:17:39 +0300
From: Dan Carpenter <error27@gmail.com>
To: Longxuan Yu <ylong030@ucr.edu>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: [bug report] 8021q: delete cleared egress QoS mappings
Message-ID: <aer889IeBHjL8na0@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 9B004459E40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280935-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello Longxuan Yu,

Commit 7dddc74af369 ("8021q: delete cleared egress QoS mappings")
from Apr 20, 2026 (linux-next), leads to the following Smatch static
checker warning:

	net/8021q/vlan_dev.c:211 vlan_dev_set_egress_priority()
	warn: duplicate zero check 'vlan_qos' (previous on line 200)

net/8021q/vlan_dev.c
    171 int vlan_dev_set_egress_priority(const struct net_device *dev,
    172                                  u32 skb_prio, u16 vlan_prio)
    173 {
    174         struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
    175         struct vlan_priority_tci_mapping __rcu **mpp;
    176         struct vlan_priority_tci_mapping *mp;
    177         struct vlan_priority_tci_mapping *np;
    178         u32 bucket = skb_prio & 0xF;
    179         u32 vlan_qos = (vlan_prio << VLAN_PRIO_SHIFT) & VLAN_PRIO_MASK;
    180 
    181         /* See if a priority mapping exists.. */
    182         mpp = &vlan->egress_priority_map[bucket];
    183         mp = rtnl_dereference(*mpp);
    184         while (mp) {
    185                 if (mp->priority == skb_prio) {
    186                         if (!vlan_qos) {
    187                                 rcu_assign_pointer(*mpp, rtnl_dereference(mp->next));
    188                                 vlan->nr_egress_mappings--;
    189                                 kfree_rcu(mp, rcu);
    190                         } else {
    191                                 WRITE_ONCE(mp->vlan_qos, vlan_qos);
    192                         }
    193                         return 0;
    194                 }
    195                 mpp = &mp->next;
    196                 mp = rtnl_dereference(*mpp);
    197         }
    198 
    199         /* Create a new mapping then. */
    200         if (!vlan_qos)
                ^^^^^^^^^^^^^^
The commit adds this check

    201                 return 0;
    202 
    203         np = kmalloc_obj(struct vlan_priority_tci_mapping);
    204         if (!np)
    205                 return -ENOBUFS;
    206 
    207         np->priority = skb_prio;
    208         np->vlan_qos = vlan_qos;
    209         RCU_INIT_POINTER(np->next, rtnl_dereference(vlan->egress_priority_map[bucket]));
    210         rcu_assign_pointer(vlan->egress_priority_map[bucket], np);
--> 211         if (vlan_qos)
                ^^^^^^^^^^^^^
So now this old one could be deleted.

    212                 vlan->nr_egress_mappings++;
    213         return 0;
    214 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

