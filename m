Return-Path: <netdev+bounces-306125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sqwnDn1vT2qiggIAu9opvQ
	(envelope-from <netdev+bounces-306125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:53:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF6872F274
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:53:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=eKFL2k+h;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306125-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306125-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7560B30166EF
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03BC3F4128;
	Thu,  9 Jul 2026 09:48:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E5E3976BC
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:48:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590516; cv=none; b=ldXhWW1+BOvA+CtPuvh4UseSXNOjEKfUXSz10LqQ0CgaVssYqCFFj9NZc4vT7t0MGX7GWn6SlHUngtIB/4hCSS1a8rOegv4xXAYANNdJdOhyRT3BFevJb7QPurh/0OeFOIuFYXtpUPSXJy9j4wqFtTIa0KfsX8aZa9H4cq5qX1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590516; c=relaxed/simple;
	bh=5MpdNiL8YTnIQQPsb7sDhdwNS/SACRbuL/oohVg8JfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3sSbwKb3hTYi8mdGecP1tqzUyght2haJnmF11f2MvXRW+IMahnfWiQL7ZRUgy/Yi+W44AyXOkcOphpdb8yGfdxxtPQrkL+gv0WDjwCe8fC17uEyh6PWPjxN3Tx2bq25g61oi4P0PAwIZZd7VFZlWddoj+jKeBaKjPPbxDUr3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKFL2k+h; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783590511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbR0KSGSt7XmeW9/13gnUCr56j3CEYZ22cwlAYHBK3o=;
	b=eKFL2k+h9vnJa049ji/zFPUfAcG9+h+bFDRi/JXSt7oEzGUZf/ENaXBtLWMmKNRaon/FKN
	CsEW38N6RnpG6THR9Ec95yqE04ASXAgqXuImHOMkspEHC3dwuifnVvZlkVqC56rPamuVaP
	sKpWTmkOZyGydve+NDmJX+08YWyklpw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-on8Ck46VNqavqFVfqGVD-A-1; Thu,
 09 Jul 2026 05:48:26 -0400
X-MC-Unique: on8Ck46VNqavqFVfqGVD-A-1
X-Mimecast-MFC-AGG-ID: on8Ck46VNqavqFVfqGVD-A_1783590505
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 992F519560B7;
	Thu,  9 Jul 2026 09:48:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.79])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9A443000C31;
	Thu,  9 Jul 2026 09:48:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: h.mahadeva@chelsio.com
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	bharat@chelsio.com
Subject: Re: [PATCH net v2] cxgb4: flower: fix 802.1ad VLAN TPID matching in tc flower filters
Date: Thu,  9 Jul 2026 11:48:16 +0200
Message-ID: <20260709094816.114720-1-pabeni@redhat.com>
In-Reply-To: <20260702044955.20119-1-h.mahadeva@chelsio.com>
References: <20260702044955.20119-1-h.mahadeva@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306125-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS(0.00)[m:h.mahadeva@chelsio.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:bharat@chelsio.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EF6872F274

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
cxgb4: flower: fix 802.1ad VLAN TPID matching in tc flower filters

This patch adds an 802.1ad branch to cxgb4_process_flow_match() that
programs a port-specific OVLAN register with ETH_P_8021AD, sets bit 0
of the RX control register, clears bit 9 of TP_INGRESS_CONFIG, and
populates the filter's outer-VLAN match fields.

A few questions about the new code follow inline.

> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
> index 3307e5042681..8c5cfa6982e7 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
> @@ -266,24 +267,48 @@ static void cxgb4_process_flow_match(struct net_device *dev,
>  					       VLAN_PRIO_SHIFT);
>  		vlan_tci_mask = match.mask->vlan_id | (match.mask->vlan_priority <<
>  						     VLAN_PRIO_SHIFT);
> -		fs->val.ivlan = vlan_tci;
> -		fs->mask.ivlan = vlan_tci_mask;
> -
> -		fs->val.ivlan_vld = 1;
> -		fs->mask.ivlan_vld = 1;
> -
> -		/* Chelsio adapters use ivlan_vld bit to match vlan packets
> [ ... ]
> -		if (fs->val.ethtype == ETH_P_8021Q) {
> -			fs->val.ethtype = 0;
> -			fs->mask.ethtype = 0;
> +
> +		if (match.key->vlan_tpid == cpu_to_be16(ETH_P_8021AD)) {

[Medium]
The gating condition consults only match.key->vlan_tpid and does not
look at match.mask->vlan_tpid.  In tc-flower semantics a key value is
only significant to the extent the mask covers it.

If a rule sets key=0x88a8 with mask=0 (don't care about TPID), this
branch is still entered and the adapter registers are still
reprogrammed.  Should this test be gated on the mask as well, similar
to how mlx5 and nfp consult the mask before honoring the key?

> +			struct adapter *adap = netdev2adap(dev);
> +			u32 ovlan_reg, ctl_reg, val, port_id;
> +
> +			if (!adap) {
> +				netdev_err(dev, "%s: adap not found\n", __func__);
> +				return;
> +			}

[Low]
netdev2adap() expands to netdev2pinfo(dev)->adapter and is not expected
to return NULL for a netdev that tc-flower can bind to.  If the check
ever did fire, cxgb4_process_flow_match() is void, so this early return
also skips the trailing:

    fs->val.iport = netdev2pinfo(dev)->port_id;
    fs->mask.iport = ~0;

and cxgb4_flow_rule_replace() would proceed to install a filter with
iport=0 / iport_mask=0.  Should the check either be removed, or the
function refactored to propagate an error?

> +
> +			val = (0xffff << 16) | ETH_P_8021AD;

[Low]
The literal 0xffff has type int (signed), so 0xffff << 16 evaluates to
a value that is not representable in a signed int.  Per C11 6.5.7 this
is undefined behavior and UBSAN's shift sanitizer flags it.  Would
0xffffU << 16 (or a symbolic _V()/_M() macro) be preferable?

The layout of MPS_PORT_RX_OVLAN0_A ([31:16]=mask, [15:0]=value) is also
not expressed through the driver's usual _S/_V/_F/_M helpers used by
neighboring registers.  Could symbolic field macros be added?

> +			port_id = netdev2pinfo(dev)->port_id;
> +			fs->val.ovlan = vlan_tci;
> +			fs->mask.ovlan = vlan_tci_mask;
> +			fs->val.ovlan_vld = 1;
> +			fs->mask.ovlan_vld = 1;

[High]
Does this ovlan programming survive on adapters that have VNIC_F set in
the cached ingress_config?  In cxgb4_filter.c, both __cxgb4_set_filter()
and cxgb4_set_hash_filter() unconditionally do:

    if (adap->params.tp.ingress_config & VNIC_F) {
        fs->val.ovlan = (fs->val.pf << 13) | fs->val.vf;
        fs->val.ovlan_vld = fs->val.pfvf_vld;
        ...
    }

which overwrites the fs->val.ovlan / fs->val.ovlan_vld set here.
validate_filter() also rejects with -EOPNOTSUPP when ovlan_vld is set
together with VNIC_F, or when the filter mode does not include
VNIC_ID_F.

On adapters where VNIC_F is enabled, does this branch actually restore
matching, or does it silently lose the VID (and, per the next comment,
still mutate hardware before failing validation)?

> +			ovlan_reg = PORT_REG(port_id, MPS_PORT_RX_OVLAN0_A);
> +			ctl_reg = PORT_REG(port_id, MPS_PORT_RX_CTL_A);
> +			t4_write_reg(adap, ovlan_reg, val);

[High]
cxgb4_process_flow_match() is called from cxgb4_flow_rule_replace()
before __cxgb4_set_filter() runs validate_filter() and the mailbox/L2T
install.  Do these three writes need to be deferred until after
validation and successful install, so that a filter rejected by
validate_filter(), or one that fails allocation/mailbox/L2T setup,
does not leave the port and adapter in a reconfigured state with no
installed filter to justify it?

Additionally, clear_filter() (cxgb4_filter.c) only tears down L2T/SMT/
CLIP and memsets the filter entry.  It does not undo MPS_PORT_RX_OVLAN0,
MPS_PORT_RX_CTL bit 0, or TP_INGRESS_CONFIG bit 9.  Is a corresponding
teardown expected on filter delete/replace so that 'tc filter add' +
'tc filter del' does not leave OVLAN matching permanently enabled and
TP_INGRESS_CONFIG bit 9 permanently cleared?

MPS_PORT_RX_OVLAN0_A is also hardcoded to slot 0 with ETH_P_8021AD as
the TPID.  How is a second concurrent flow rule requesting a different
outer TPID intended to be represented, given that installing it would
clobber slot 0?

> +			val = t4_read_reg(adap, ctl_reg);
> +			t4_write_reg(adap, ctl_reg, val | 1);

[High]
This RMW on MPS_PORT_RX_CTL_A is unserialized.  If another context
modifies other bits of the same register between the read and the
write, that update is lost.  Is there a lock that should be held here
(win0_lock or similar)?

> +			t4_tp_wr_bits_indirect(adap, TP_INGRESS_CONFIG_A, 1U << 9, 0);

[High, Medium, Medium]
t4_tp_wr_bits_indirect() drives the TP_PIO_ADDR_A / TP_PIO_DATA_A
indirect-register pair:

    void t4_tp_wr_bits_indirect(struct adapter *adap, unsigned int addr,
                                unsigned int mask, unsigned int val)
    {
        t4_write_reg(adap, TP_PIO_ADDR_A, addr);
        val |= t4_read_reg(adap, TP_PIO_DATA_A) & ~mask;
        t4_write_reg(adap, TP_PIO_DATA_A, val);
    }

Before this patch the only in-tree caller was probe-time
adap_init0_tweaks().  This patch adds a runtime, user-triggerable
caller.

Can a concurrent TP_PIO user (t4_tp_pio_read/t4_tp_pio_write when LDST
is unavailable, register-dump code, or another tc-flower install on a
different netdev of the same adapter) interleave between the ADDR
write and the DATA read/write and cause the wrong TP register to be
read or written?  What serializes the TP_PIO_ADDR_A/TP_PIO_DATA_A pair
here?

Separately, the hardware bit is toggled but adap->params.tp.ingress_config
is not updated.  That shadow is consulted throughout cxgb4_filter.c
(validate_filter, __cxgb4_set_filter, cxgb4_set_hash_filter) and l2t.c
to make VNIC_F / USE_ENC_IDX_F / ovlan-vs-pfvf decisions.  Should the
shadow be kept in sync with the hardware write?

Also, bit 9 of TP_INGRESS_CONFIG_A is written as the bare literal
1U << 9, while neighboring bits of the same register are exposed as
_S/_V/_F macros in t4_regs.h (CSUM_HAS_PSEUDO_HDR_S=10, VNIC_S=11,
USE_ENC_IDX_S=13).  What feature does bit 9 control, and could a
symbolic name be introduced?  The commit message enumerates three
actions (OVLAN register, RX control enable, filter fields) but does
not mention this fourth adapter-wide write.

> +		} else {
> +			fs->val.ivlan = vlan_tci;
> +			fs->mask.ivlan = vlan_tci_mask;
> +			fs->val.ivlan_vld = 1;
> +			fs->mask.ivlan_vld = 1;
> +
> +			/* Chelsio adapters use ivlan_vld bit to match vlan packets
> +			 * as 802.1Q. Also, when vlan tag is present in packets,
> +			 * ethtype match is used then to match on ethtype of inner
> +			 * header ie. the header following the vlan header.
> +			 * So, set the ivlan_vld based on ethtype info supplied by
> +			 * TC for vlan packets if its 802.1Q. And then reset the
> +			 * ethtype value else, hw will try to match the supplied
> +			 * ethtype value with ethtype of inner header.
> +			 */
> +
> +			if (fs->val.ethtype == ETH_P_8021Q) {
> +				fs->val.ethtype = 0;
> +				fs->mask.ethtype = 0;
> +			}

[High]
The preserved comment states that the hardware ethtype field matches
the ethtype after the outer VLAN tag (the inner header), and the
802.1Q branch resets fs->val.ethtype/fs->mask.ethtype to avoid a
mismatch.

The new 802.1ad branch above does not perform the equivalent reset.
For a common rule such as:

    tc filter add ... flower \
        vlan_ethtype 0x88a8 vlan_id X ...

FLOW_DISSECTOR_KEY_BASIC processing earlier in the same function has
already set fs->val.ethtype = 0x88a8, but the ethtype field is matched
against the inner header (which for real 802.1ad traffic is 0x8100 or
an L3 protocol, never 0x88a8).  Should the 802.1ad branch clear
fs->val.ethtype / fs->mask.ethtype the same way the 802.1Q branch
does?

>  		}
>  	}
>  
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h b/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
> index 695916ba0405..38c585f3b1ad 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
> +++ b/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
> @@ -1921,6 +1921,9 @@
>  #define MAC_PORT_PTP_SUM_LO_A 0x990
>  #define MAC_PORT_PTP_SUM_HI_A 0x994
>  
> +#define MPS_PORT_RX_OVLAN0_A 0x120
> +#define MPS_PORT_RX_CTL_A    0X100

[Low]
This isn't a bug, but the hex prefix on 0X100 is uppercase while the
line above (and every neighboring macro) uses lowercase 0x.  Was that
intentional?

> +
>  #define MPS_CMN_CTL_A	0x9000
-- 
This is an AI-generated review.


