Return-Path: <netdev+bounces-272157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHL1Hs1nxWl1+AQAu9opvQ
	(envelope-from <netdev+bounces-272157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:07:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95934338E7D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B645301DCFA
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7836740756B;
	Thu, 26 Mar 2026 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="t1bWYVf4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0120385526
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544564; cv=none; b=CXiJ569oI8dPW1UjxIt4FAPtmzsfLJtJR3WGL3mtK2vYay95ckaq8Nv0Qs/1FGl14WH/bkfC77kJyaj0G+ukcvpb54xisFcp1yP+/grMrsnXWYN3rQljagwUVLfOtvBDhXWSBDuzkclxZfKs5Mb2yUqKyjDiDUoKkrNqGJkhLYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544564; c=relaxed/simple;
	bh=6A8JoCjSKsdZBMWA9MOK2LfEQrLWoM6rgQMbwDedt+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXsCURrde9k9RypM38F4sv9xtXBCElqxUZ484B9cwaK1w6OCtXNsNvNM73IVZ1X5GxEA1IH417oy5YFDJmMMmzLOgUn7xtesu+OmGZ6wrNKoV7JnGA9vlbMGBBcxrB2yWddxaQSOyhrbMHUcfAaK9ntTzcKPYrnMhGPeri7dP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=t1bWYVf4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2adff872068so5159735ad.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774544562; x=1775149362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oth5mhTJ39EvtSrKINf1neXZ7BWti1esZSUQXviFbSk=;
        b=t1bWYVf4mCjHqcEpeQrhNw3XS7A23/t5af1GvJMdTR90sKyFWxrtR0IeLRU0uwtoa0
         w58Soy5ZcRIvz4LcoTZvqJALypQ3medd74HJqGBaeOFHlO0LfTkVTuA5OCmQ22fIW1ud
         2p0FF3/nPAbR9/Y0QCevXfG3yBgpQDIXtH5MVb+slpesDJ9THhe859xXmTH91OPKMEo5
         mucfoDjVzPkTIVwGpFH+EMzZ/dWe3rBlaTswIL+MKBmdwiJPOUjHBSKouAaaPzXpAYKt
         0/11J8IthTTe0h/u+OV9LIbGIsUTuN4v+izTiRfE1K+cPBzZ4+7YZD+mwlbm+CTPORc1
         Jhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544562; x=1775149362;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oth5mhTJ39EvtSrKINf1neXZ7BWti1esZSUQXviFbSk=;
        b=cP/GT8PWTNBHCDAwbi71lPJGN9FGZiBKbSvTHoP4DwK5p9ICv/PXFsAjJkObmSbZ2p
         WxbU+N1aYkCG856LzQ8+0MoR+yoHR9G27Eh92LkxGXFYzskk2iduVK7JkagwJycAE1I8
         kDSMXIncs4w4IDrZlsOsf01Av1t3/PQedJpzH1Q03M++Y6zdT9Nu075mEt5E4Fk/AOrQ
         M2xzMAJAP+ExkX6/IBq88Ptze/K5Yvfig/3JbSsROZ9cXiV2ZGjXJ4B3vZ7Zr0VDHfBs
         EZmhSyc4dhWOItg/zwjc26wH72KGIGaB07t4+nf+83uMBcsb2oiwlbGljJnVNp3oyMIf
         Y9LQ==
X-Gm-Message-State: AOJu0YyLlD2Ux6oQ4Z/xnEUATtuCT3sJ8yUR3dWQ4CjDFmwKFMzUiZue
	xQR1khZG7AofdB4qp19NVVoB/F9xwrNRG3MNuB/zHoACPLr+vHOuSid5+5x7O4v+vrE=
X-Gm-Gg: ATEYQzxFkDOSknRJ605mCkoilzkstveYJTmwWdNlK7h6NNGwiS6QuVbtwrf7/udaFNr
	g5pyWqFmXVfajWkLeF6ZcajsXYyq46ActCe4NABsTKGrJ/UWXkaBsv76vWpIuYPnrNfLH2n30lD
	lYeMqXDzbkoG2Qc+atzRbE4DKX/OKqLtemDvqgYF0rBEGssiIww9vfwYyW9QdXaNCkXGEWeURur
	zyRNkQEikWg8BsjEV17VR9vJ/h64coBD+wzlDDO1tpQZ0WDuZ+7nmj0ATObXA/Y8HkHuIcRUtIw
	hROvzPF5sgpEEyOcfvrbOz9h7A4YqNEOFWZX3LvtcPbKGlei7fpdoDxG4uBZSL9SzrRGVcy7dJJ
	/OfaoTQ08C0yMOZmOpwbEZCXutCK9yYNI5vXYzK4mNsRPVSxDN8gZ+wdhEqd3Ot9gYlxe0ZXvKT
	Tua0Z9
X-Received: by 2002:a17:903:1a86:b0:2ae:7f28:124b with SMTP id d9443c01a7336-2b0b0a153ffmr82939605ad.22.1774544562088;
        Thu, 26 Mar 2026 10:02:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76b8c3sm47872255ad.14.2026.03.26.10.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:02:41 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:02:39 -0700
From: Joe Damato <joe@dama.to>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, horms@kernel.org,
	linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v5 09/12] net: bnxt: Add SW GSO completion and
 teardown support
Message-ID: <acVmr9gxjm6mJ0IJ@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, horms@kernel.org,
	linux-kernel@vger.kernel.org, leon@kernel.org
References: <20260323183844.3146982-1-joe@dama.to>
 <20260323183844.3146982-10-joe@dama.to>
 <ab1f764b-de03-48f5-a781-356495257d25@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1f764b-de03-48f5-a781-356495257d25@redhat.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272157-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95934338E7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 01:39:17PM +0100, Paolo Abeni wrote:
> On 3/23/26 7:38 PM, Joe Damato wrote:
> > Update __bnxt_tx_int and bnxt_free_one_tx_ring_skbs to handle SW GSO
> > segments:
> > 
> > - MID segments: adjust tx_pkts/tx_bytes accounting and skip skb free
> >   (the skb is shared across all segments and freed only once)
> > 
> > - LAST segments: if the DMA IOVA path was used, use dma_iova_destroy to
> >   tear down the contiguous mapping. On the fallback path, payload DMA
> >   unmapping is handled by the existing per-BD dma_unmap_len walk.
> > 
> > Both MID and LAST completions advance tx_inline_cons to release the
> > segment's inline header slot back to the ring.
> > 
> > is_sw_gso is initialized to zero, so the new code paths are not run.
> > 
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > Signed-off-by: Joe Damato <joe@dama.to>
> > ---
> >  v5:
> >    - Added Pavan's Reviewed-by. No functional changes.
> > 
> >  v3:
> >    - completion paths updated to use DMA IOVA APIs to teardown mappings.
> > 
> >  rfcv2:
> >    - Update the shared header buffer consumer on TX completion.
> > 
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 82 +++++++++++++++++--
> >  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 ++++-
> >  2 files changed, 91 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > index 2759a4e2b148..40a16f96feba 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -74,6 +74,8 @@
> >  #include "bnxt_debugfs.h"
> >  #include "bnxt_coredump.h"
> >  #include "bnxt_hwmon.h"
> > +#include "bnxt_gso.h"
> > +#include <net/tso.h>
> >  
> >  #define BNXT_TX_TIMEOUT		(5 * HZ)
> >  #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
> > @@ -817,12 +819,13 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
> >  	bool rc = false;
> >  
> >  	while (RING_TX(bp, cons) != hw_cons) {
> > -		struct bnxt_sw_tx_bd *tx_buf;
> > +		struct bnxt_sw_tx_bd *tx_buf, *head_buf;
> >  		struct sk_buff *skb;
> >  		bool is_ts_pkt;
> >  		int j, last;
> >  
> >  		tx_buf = &txr->tx_buf_ring[RING_TX(bp, cons)];
> > +		head_buf = tx_buf;
> >  		skb = tx_buf->skb;
> >  
> >  		if (unlikely(!skb)) {
> > @@ -869,6 +872,23 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
> >  							    DMA_TO_DEVICE, 0);
> >  			}
> >  		}
> > +
> > +		if (unlikely(head_buf->is_sw_gso)) {
> > +			txr->tx_inline_cons++;
> > +			if (head_buf->is_sw_gso == BNXT_SW_GSO_LAST) {
> > +				if (dma_use_iova(&head_buf->iova_state))
> 
> I'm likely lost, but AFAICS the previous patch/bnxt_sw_udp_gso_xmit()
> initialize head_buf->iova_state only when
> `dma_use_iova(&head_buf->iova_state) == true`. I.e. in fallback scenario
> the previous iova_state is maintained.

Note that calling dma_iova_try_alloc zeroes the state before returning whether
the IOVA DMA API can be used or not and I call that uncoditionally (see
below).

> Additionally AFAICS dma_iova_destroy does not clear `head_buf->iova_state`.

That's my understanding, too, that dma_iova_destroy doesn't clear the state.
 
> It looks like that 2 consecutive skb hitting the same slot use a
> different dma mapping strategy (fallback vs iova) bat things will
> happen?!? should the previous patch always initializing
> head_buf->iova_state?

AFAICT, to switch the IOMMU domain would require unbind the device, changing
the IOMMU type, and re-binding the device... which would destroy all the rings
in the process and thus this wouldn't happen.

The only way I could potentially imagine this happening would be in extreme
IOVA pressure (maybe?):
  - packet A in slot N, dma_iova_try_alloc suceeds -> head_buf->iova_state
    copied
  - completion the packet occurs, dma_iova_destroy is called,
    head_buf->iova_state is not cleared
  - packet B in slot N, dma_iova_try_alloc fails due to IOVA pressure...
    head_buf->iova_state is stale

I'm pretty skeptical that this is a realistic case, TBH.

That said and since it seems my v5 got CR, I can send a v6 with this slight
change to address the case you've mentioned above.

I'll send in a couple hours unless I hear otherwise:

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
index 9c30ee063ef5..7c198847a771 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -142,8 +142,12 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,

                tx_buf->is_sw_gso = last ? BNXT_SW_GSO_LAST : BNXT_SW_GSO_MID;

-               /* Store IOVA state on the last segment for completion */
-               if (last && tso_dma_map_use_iova(&map)) {
+               /* Store IOVA state on the last segment for completion.
+                * Always copy so that a stale iova_state from a prior
+                * occupant of this ring slot cannot be misread by
+                * dma_use_iova() in the completion path.
+                */
+               if (last) {
                        tx_buf->iova_state = map.iova_state;
                        tx_buf->iova_total_len = map.total_len;
                }

