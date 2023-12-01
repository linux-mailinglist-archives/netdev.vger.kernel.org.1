Return-Path: <netdev+bounces-53106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA838014C2
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 21:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65DE1F20C73
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 20:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8989A4E1C2;
	Fri,  1 Dec 2023 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="qRKygQFE"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 12:44:51 PST
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100E310C2
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 12:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=U7IpRU6j1qikuqMBg94vlnJkuypow2RWr1EoPsfN5K0=;
  b=qRKygQFEXugzA+w3XWBXYOoAfXR6NqIC2D/CIA6lEHqNG04UEcw/mDj5
   4m8iPpvEIqBTN4x2nLZuUNMqec1slXX2M1bWotsr1DI4SdlWsSr7ZCVOM
   ZaFFj7kt1XG99xrypuQ2EYaAIq7QfJh9GET13qeXQajMTk2unrHUbK4iZ
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,242,1695679200"; 
   d="scan'208";a="139736054"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 21:43:46 +0100
Date: Fri, 1 Dec 2023 21:43:45 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
    intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
    anthony.l.nguyen@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] idpf: refactor some missing
 field get/prep conversions
In-Reply-To: <97ed09be-cb2b-48c3-846d-7a0e453ef816@intel.com>
Message-ID: <alpine.DEB.2.22.394.2312012138350.5933@hadrien>
References: <20231130214511.647586-1-jesse.brandeburg@intel.com> <212e5518-0f72-4bf5-bc5f-49d184be1931@intel.com> <97ed09be-cb2b-48c3-846d-7a0e453ef816@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 1 Dec 2023, Jesse Brandeburg wrote:

> On 12/1/2023 6:32 AM, Alexander Lobakin wrote:
> > From: Jesse Brandeburg <jesse.brandeburg@intel.com>
>
> >> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> >> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> >> @@ -505,7 +505,7 @@ static void idpf_rx_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
> >>
> >>  	/* store the buffer ID and the SW maintained GEN bit to the refillq */
> >>  	refillq->ring[nta] =
> >> -		((buf_id << IDPF_RX_BI_BUFID_S) & IDPF_RX_BI_BUFID_M) |
> >> +		FIELD_PREP(IDPF_RX_BI_BUFID_M, buf_id) |
> >>  		(!!(test_bit(__IDPF_Q_GEN_CHK, refillq->flags)) <<
> >>  		 IDPF_RX_BI_GEN_S);
> >
> > Why isn't that one converted as well?
>
> Because it's not a constant, and it's not checking a mask with "&", so
> the automation ignored it. I *did* a test, and we could convert the
> return value from test_bit (a bool) into the IDPF_RX_BI_GEN_M mask with
> FIELD_PREP, since C-code allows the luxury of converting a bool to a
> "1", even though it's a bit type ugly in this age of strict typing.
>
> >
> >>
> >> @@ -1825,14 +1825,14 @@ static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
> >>  		u16 gen;
> >>
> >>  		/* if the descriptor isn't done, no work yet to do */
> >> -		gen = (le16_to_cpu(tx_desc->qid_comptype_gen) &
> >> -		      IDPF_TXD_COMPLQ_GEN_M) >> IDPF_TXD_COMPLQ_GEN_S;
> >> +		gen = FIELD_GET(IDPF_TXD_COMPLQ_GEN_M,
> >> +				le16_to_cpu(tx_desc->qid_comptype_gen));
> >
> > The definition:
> >
> > #define IDPF_TXD_COMPLQ_GEN_M		BIT_ULL(IDPF_TXD_COMPLQ_GEN_S)
> >
> > Please don't use FIELD_*() API for 1 bit.
>
> Did you mean that gen is effectively used as a bool? I think that has
> nothing to do with my change over to FIELD_GET, but I could see how
> redesigning this code would be useful, but not as part of this
> conversion series.
>
> >
> > 		gen = !!(le16_to_cpu(tx_desc->qid_comptype_gen) &
> > 			 IDPF_TXD_COMPLQ_GEN_M);
> >
> > is enough.
>
> Generally I'd prefer that the kind of check above returned a bool with a
> constant conversion of the mask (compile time) to an LE16 mask, and then
> use that, which is why all of our other drivers do that instead.
>
> >
> > Moreover, you could use le*_{get,encode,replace}_bits() to get/set LE
> > values right away without 2-step operation (from/to CPU + masks), but
> > you didn't do that here (see below for an example).
>
> Those aren't widely used yet in our drivers so I wasn't picking them up
> yet. But thank you for pointing that out.
>
> <snip>
>
>
> > In general, I would say those two issues are very common in IDPF and
> > also the whole your series converting the Intel drivers. The scripts
> > won't check whether the mask has only 1 bit or whether the value gets
> > converted from/to LE, so they won't help here.
>
> I had been hoping to do some more followup work. it's possible that with
> some tweaking the coccinelle script could learn how to detect non-pow2
> constants, and therefore possibly one bit constants as well. Maybe
> @Julia can help us refine the script and possibly get it into the
> scripts/coccinelle directory to help other drivers as well.

I don't have the original script handy.

If it is an explicit constant, like 8, then you can match it with
something like:

constant pow2 : script:python() { is_pow2(pow2) };

where is_pow2 is a python function that first converts pow2 to an integer,
and then, if that succeeds, checks if it is a power of two.  The result of
is_pow2 should be true or false.

When there is a #define constant, then you can to match the #define to
determine the value.  This may require options like --all-includes or
--recursive-includes.

Then you can write:

@r@
constant pow2 : script:python() { is_pow2(pow2) };
identifier i;
@@

#define i pow2

and then in some later rule, you can have

identifier r.i;

and then use i in a place where you expect a power of two constant.

julia


>
> > Could you maybe manually recheck all the places where bitfield masks are
> > used at least in IDPF (better in ice, iavf, i40e, ..., as well) and
> > posted a series that would address them? At the end, manual work is more
> > valuable than automated conversions :p
>
> I think a followup series would work better for this, do you agree?
>
> Thanks,
> Jesse
>

