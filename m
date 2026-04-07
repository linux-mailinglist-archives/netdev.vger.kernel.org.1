Return-Path: <netdev+bounces-276032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BLmBLEe1Wnr0wcAu9opvQ
	(envelope-from <netdev+bounces-276032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:11:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3E93B0B49
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B2193022F8F
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01335AC35;
	Tue,  7 Apr 2026 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcF3yEeS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD333D505
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574305; cv=none; b=EGVZYoiSHmFuKZ2v04uBvQAaEZ+XyFDlnrYbkZKqBlm8vodJTeURWGLPkplb3xB91SIcYywCK5vMUVFdpmbdqgrf/BaTj8PIcaceSJNQG1tv1TnCISfLgwwC0ItZmcO7Pugm2mbqaqRrq5T+jEUZfJiDxWyUVW9lU+CkLFYmpOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574305; c=relaxed/simple;
	bh=CrHC1vD81873jVQYixK/Cr+dwWyTeJpHEOcDeR5UeO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoB10xef0sfHm7RysIeZJMlUuDh88jxGbaLrilgexFLHGdn9fhnKoCjR0hJiMJVoUTIAy23IHXYBhOX+gnC2ZbhdrpDc53o7YmJLsm+dj17JJ4EVBgryorUbY3L+3YY0n0aLTfYnrkqRvSmyAIWI3EZuSQrFL7nNsXFaJ95OuO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcF3yEeS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775574302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Djh8MbEYjD06cLgWg4zobo1Zy061MpN/vRaKzdCUstg=;
	b=GcF3yEeSXtYECnQfJ3SihD8YzCWvZ2/dIua0/bRZwSdhx3oEiUsF1a8JVYIiUuThYIPoxq
	kC8ZGQJ1nEfekFtGKqWMbgrdRFmxpzDPYLM+fjTaAzzhES8Rcaroc6REv2q10QbtFYVcHA
	dDgfOcNbzVlu7GcFkfQSNhGJ/s2qM8c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-PQ-dHuJOMduQilzCCKtqPg-1; Tue,
 07 Apr 2026 11:05:01 -0400
X-MC-Unique: PQ-dHuJOMduQilzCCKtqPg-1
X-Mimecast-MFC-AGG-ID: PQ-dHuJOMduQilzCCKtqPg_1775574300
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7B101956068;
	Tue,  7 Apr 2026 15:04:59 +0000 (UTC)
Received: from thinkpad (unknown [10.44.50.90])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C821300019F;
	Tue,  7 Apr 2026 15:04:56 +0000 (UTC)
Date: Tue, 7 Apr 2026 17:04:53 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>,
	Luka Gejak <luka.gejak@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next v4 1/2] net: hsr: require valid EOT supervision
 TLV
Message-ID: <adUdFTckCG7ELIra@thinkpad>
References: <20260401092324.52266-1-luka.gejak@linux.dev>
 <20260401092324.52266-2-luka.gejak@linux.dev>
 <2d94a1a6-e6c5-427c-b10f-63377cb10407@suse.de>
 <DHHZ8POWJINS.1CRKQT33EM1WW@linux.dev>
 <4cce92eb-61a0-4869-8a30-b86d65e8a675@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cce92eb-61a0-4869-8a30-b86d65e8a675@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276032-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 6B3E93B0B49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 01:53:14AM +0200, Fernando Fernandez Mancera wrote:
> On 4/1/26 6:59 PM, Luka Gejak wrote:
> > On Wed Apr 1, 2026 at 4:47 PM CEST, Fernando Fernandez Mancera wrote:
> > > On 4/1/26 11:23 AM, luka.gejak@linux.dev wrote:
> > > > From: Luka Gejak <luka.gejak@linux.dev>
> > > >
> > > > Supervision frames are only valid if terminated with a zero-length EOT
> > > > TLV. The current check fails to reject non-EOT entries as the terminal
> > > > TLV, potentially allowing malformed supervision traffic.
> > > >
> > > > Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT
> > > > with a length of zero.
> > > >
> > > > Reviewed-by: Felix Maurer <fmaurer@redhat.com>
> > > > Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> > > > ---
> > > >    net/hsr/hsr_forward.c | 41 ++++++++++++++++++++++-------------------
> > > >    1 file changed, 22 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > > > index 0aca859c88cb..17b705235c4a 100644
> > > > --- a/net/hsr/hsr_forward.c
> > > > +++ b/net/hsr/hsr_forward.c
> > > > @@ -82,39 +82,42 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
> > > >    	    hsr_sup_tag->tlv.HSR_TLV_length != sizeof(struct hsr_sup_payload))
> > > >    		return false;
> > > > -	/* Get next tlv */
> > > > +	/* Advance past the first TLV payload to reach next TLV header */
> > > >    	total_length += hsr_sup_tag->tlv.HSR_TLV_length;
> > > > -	if (!pskb_may_pull(skb, total_length))
> > > > +	/* Linearize next TLV header before access */
> > > > +	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
> > > >    		return false;
> > > >    	skb_pull(skb, total_length);
> > > >    	hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
> > > >    	skb_push(skb, total_length);
> > > > -	/* if this is a redbox supervision frame we need to verify
> > > > -	 * that more data is available
> > > > +	/* Walk through TLVs to find end-of-TLV marker, skipping any unknown
> > > > +	 * extension TLVs to maintain forward compatibility.
> > > >    	 */
> > > > -	if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
> > > > -		/* tlv length must be a length of a mac address */
> > > > -		if (hsr_sup_tlv->HSR_TLV_length != sizeof(struct hsr_sup_payload))
> > > > -			return false;
> > > > +	for (;;) {
> > > > +		if (hsr_sup_tlv->HSR_TLV_type == HSR_TLV_EOT &&
> > > > +		    hsr_sup_tlv->HSR_TLV_length == 0)
> > > > +			return true;
> > >
> > > I do not follow this approach, why a loop? From IEC 62439-3, I do not
> > > understand that supervision frames could have multiple
> > > PRP_TLV_REDBOX_MAC TLVs. The current code handles the TLVs correctly.
> > >
> > > Which makes me wonder, how are you testing this? Do you have some
> > > hardware with HSR/PRP support that is sending these frames? If so, which
> > > one? Are you testing this using a HSR/PRP environment with purely Linux
> > > devices?
> > >
> > > Thanks,
> > > Fernando.
> > >
> > > > -		/* make sure another tlv follows */
> > > > -		total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_length;
> > > > -		if (!pskb_may_pull(skb, total_length))
> > > > +		/* Validate known TLV types */
> > > > +		if (hsr_sup_tlv->HSR_TLV_type == PRP_TLV_REDBOX_MAC) {
> > > > +			if (hsr_sup_tlv->HSR_TLV_length !=
> > > > +			    sizeof(struct hsr_sup_payload))
> > > > +				return false;
> > > > +		}
> > > > +
> > > > +		/* Advance past current TLV: header + payload */
> > > > +		total_length += sizeof(struct hsr_sup_tlv) +
> > > > +				hsr_sup_tlv->HSR_TLV_length;
> > > > +		/* Linearize next TLV header before access */
> > > > +		if (!pskb_may_pull(skb,
> > > > +				   total_length + sizeof(struct hsr_sup_tlv)))
> > > >    			return false;
> > > > -		/* get next tlv */
> > > >    		skb_pull(skb, total_length);
> > > >    		hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
> > > >    		skb_push(skb, total_length);
> > > >    	}
> >
> > Hi Fernando,
> >
> > You are right that IEC 62439-3 does not specify multiple
> > PRP_TLV_REDBOX_MAC TLVs. My intention with the loop was not to handle
> > multiple RedBox MACs, but rather to make the parser robust against
> > unknown TLV types. If a future revision of the standard or a vendor
> > extension introduces a new TLV, the loop allows the kernel to safely
> > skip over unrecognized TLVs by reading their length, ensuring it can
> > still validate the HSR_TLV_EOT marker at the end.

Hi Fernando, Luka,

> AFAIU, the TLVs must be in the right order. I don't know, it doesn't sound
> very convincing to me that we are anticipating to new TLVs. HSR/PRP isn't a
> very active protocol and it has few users in Kernel probably compare to
> other protocols because it is used in a very specific industry domain.

I agree with this. IMHO, the supervision frames should look the way they
are described in the standard, i.e., the TLVs ordered as the current
code expects them.

Luka, I'm not sure what your stance is to that? On one hand, you are
proposing a patch making the checks more strict (TLV_END && length ==
0), on the other hand you are proposing a patch accepting supervision
frames with random new or proprietary TLVs.

> If a new revision of the protocol specs is released we can always update our
> implementation.

This, especially because the supervision frames have an explicit version
number field (something we don't check at the moment, but probably
should in the future).

> Anyway, since Felix reviewed the initial patch let's wait for his review.

I'll add more notes in another reply, directly to the patch.

> > However, if the preference for the HSR subsystem is strict adherence to
> > only currently defined TLVs over forward compatibility, I completely
> > understand.
> >
> > Furthermore, I am testing this using a purely Linux environment by
> > using a virtual HSR environment on Arch Linux. I set up two network
> > namespaces connected via veth pairs and instantiated HSR interfaces.
> >
> > The nodes successfully synchronized and maintained the connection. I
> > confirmed this by observing the expected duplicate packets (DUP!)
> > during ping tests between namespaces and by verifying that supervision
> > frames were correctly parsed, allowing the nodes to populate their
> > remote node tables.

Side note: hsr exposes the node table through debugfs, that's maybe a
better way to test/verify such things.

Thanks,
   Felix


