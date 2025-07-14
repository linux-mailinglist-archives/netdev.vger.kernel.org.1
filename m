Return-Path: <netdev+bounces-206624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B50B03C84
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 12:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9C63AD1E4
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253D425D212;
	Mon, 14 Jul 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIP+4TQ9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01F525CC62;
	Mon, 14 Jul 2025 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489964; cv=none; b=QQEEjNBfkVjypl4h6H8X258GC7gEzMXuFpOu8iTrvmXbg/BAD6EO+Oqcr/k6GhnSxDhD04uh5qcpodwSX+mA2Xy71aiOG/Bd0xnj8Itk0jpBnj8Fqk1gCjKiibcizACbgqc2keuLnf2/Xij0oPu6lwPmP6nWRjA/ufrjq6dDpEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489964; c=relaxed/simple;
	bh=EHp+U2DAG79o1a2tBY+0M7uwUKpUfbK6FqGEdiexLEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhqVmQOQ3dTDB8mXCi0UcD34fqAWJ7yM4JNEERENUyAo+8qHjdulPbJuZK6NPz5K34ef9uRwHd33j2e7in7SSCMS6P3zjRo3v53HFoe15D8VmtBizHOG/zAuMRXGRdk+148rXAqOskrP/MPpyzMJmlOepwsHke+1e1Flrrnizbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIP+4TQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C9FC4CEFE;
	Mon, 14 Jul 2025 10:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752489963;
	bh=EHp+U2DAG79o1a2tBY+0M7uwUKpUfbK6FqGEdiexLEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIP+4TQ9IO7AdK95xEYp8Dwsg8Jr+Pjrc+06gsSMb+jtfgEbA1HfR8kOl69Nbb0ED
	 b+VYlLWqxEWVTwEkGp56JPcnighHzhFY/9sbdnwF3iXd5lGFsNQekFD2ShUvxiLrnz
	 XvIjU84ZHc0qu8QK0ft5twkUItvVslfFJpF7vioJiM69LaNhp8lC2/Hu4JpSPgn7eV
	 QCbBV2OhWMMFt4KaOtFv7q0fq5SkSGofbTxYwlL36W7ELowwp7Yjrp6T050GA1COZT
	 zzkZdfUzR+wf3Cc3Sd86D+a+Et93qrHEmCOC4sIuoJi7gIuwI+yp9TzK9sKUiuyyWJ
	 oLJk4Zov81MWw==
Date: Mon, 14 Jul 2025 11:45:57 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com,
	lcherian@marvell.com, sgoutham@marvell.com, netdev@vger.kernel.org,
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [net-next PATCH 01/11] octeontx2-af: Simplify context writing
 and reading to hardware
Message-ID: <20250714104557.GG721198@horms.kernel.org>
References: <1752420669-2908-1-git-send-email-sbhatta@marvell.com>
 <1752420669-2908-2-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752420669-2908-2-git-send-email-sbhatta@marvell.com>

+ Kees, linux-hardening

On Sun, Jul 13, 2025 at 09:00:59PM +0530, Subbaraya Sundeep wrote:
> Simplify NIX context reading and writing by using hardware
> maximum context size instead of using individual sizes of
> each context type.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 46 ++++++++++---------
>  1 file changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index bdf4d852c15d..48d44911b663 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -17,6 +17,8 @@
>  #include "lmac_common.h"
>  #include "rvu_npc_hash.h"
>  
> +#define NIX_MAX_CTX_SIZE	128
> +
>  static void nix_free_tx_vtag_entries(struct rvu *rvu, u16 pcifunc);
>  static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
>  			    int type, int chan_id);
> @@ -1149,36 +1151,36 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
>  	case NIX_AQ_INSTOP_WRITE:
>  		if (req->ctype == NIX_AQ_CTYPE_RQ)
>  			memcpy(mask, &req->rq_mask,
> -			       sizeof(struct nix_rq_ctx_s));
> +			       NIX_MAX_CTX_SIZE);
>  		else if (req->ctype == NIX_AQ_CTYPE_SQ)
>  			memcpy(mask, &req->sq_mask,
> -			       sizeof(struct nix_sq_ctx_s));
> +			       NIX_MAX_CTX_SIZE);
>  		else if (req->ctype == NIX_AQ_CTYPE_CQ)
>  			memcpy(mask, &req->cq_mask,
> -			       sizeof(struct nix_cq_ctx_s));
> +			       NIX_MAX_CTX_SIZE);
>  		else if (req->ctype == NIX_AQ_CTYPE_RSS)
>  			memcpy(mask, &req->rss_mask,
> -			       sizeof(struct nix_rsse_s));
> +			       NIX_MAX_CTX_SIZE);
>  		else if (req->ctype == NIX_AQ_CTYPE_MCE)
>  			memcpy(mask, &req->mce_mask,
> -			       sizeof(struct nix_rx_mce_s));
> +			       NIX_MAX_CTX_SIZE);
>  		else if (req->ctype == NIX_AQ_CTYPE_BANDPROF)
>  			memcpy(mask, &req->prof_mask,
> -			       sizeof(struct nix_bandprof_s));
> +			       NIX_MAX_CTX_SIZE);
>  		fallthrough;

Hi Subbaraya,

Unfortunately this patch adds string fortification warnings
because, e.g. the size of req->rss_mask is less than 128 bytes.

GCC 15.1.0 flags this as follows:

  In function 'fortify_memcpy_chk',
      inlined from 'rvu_nix_blk_aq_enq_inst' at drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:1159:4:
  ./include/linux/fortify-string.h:580:4: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()?
      __read_overflow2_field(q_size_field, size);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There may there is nicer way to do this. And it's entirely possible I've
muddled up the combination of structures and unions here. But I wonder if
an approach like this can reach your goals wile keeping the string
fortification checker happy.

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 0bc0dc79868b..0aa1e823cbd3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -985,14 +985,17 @@ struct nix_aq_enq_req {
 		struct nix_rx_mce_s mce;
 		struct nix_bandprof_s prof;
 	};
-	union {
-		struct nix_rq_ctx_s rq_mask;
-		struct nix_sq_ctx_s sq_mask;
-		struct nix_cq_ctx_s cq_mask;
-		struct nix_rsse_s   rss_mask;
-		struct nix_rx_mce_s mce_mask;
-		struct nix_bandprof_s prof_mask;
-	};
+	struct_group(
+		mask,
+		union {
+			struct nix_rq_ctx_s rq_mask;
+			struct nix_sq_ctx_s sq_mask;
+			struct nix_cq_ctx_s cq_mask;
+			struct nix_rsse_s   rss_mask;
+			struct nix_rx_mce_s mce_mask;
+			struct nix_bandprof_s prof_mask;
+		};
+	);
 };
 
 struct nix_aq_enq_rsp {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index bdf4d852c15d..4089933d5a0b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1147,24 +1147,7 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 
 	switch (req->op) {
 	case NIX_AQ_INSTOP_WRITE:
-		if (req->ctype == NIX_AQ_CTYPE_RQ)
-			memcpy(mask, &req->rq_mask,
-			       sizeof(struct nix_rq_ctx_s));
-		else if (req->ctype == NIX_AQ_CTYPE_SQ)
-			memcpy(mask, &req->sq_mask,
-			       sizeof(struct nix_sq_ctx_s));
-		else if (req->ctype == NIX_AQ_CTYPE_CQ)
-			memcpy(mask, &req->cq_mask,
-			       sizeof(struct nix_cq_ctx_s));
-		else if (req->ctype == NIX_AQ_CTYPE_RSS)
-			memcpy(mask, &req->rss_mask,
-			       sizeof(struct nix_rsse_s));
-		else if (req->ctype == NIX_AQ_CTYPE_MCE)
-			memcpy(mask, &req->mce_mask,
-			       sizeof(struct nix_rx_mce_s));
-		else if (req->ctype == NIX_AQ_CTYPE_BANDPROF)
-			memcpy(mask, &req->prof_mask,
-			       sizeof(struct nix_bandprof_s));
+		memcpy(mask, &req->mask, sizeof(req->mask));
 		fallthrough;
 	case NIX_AQ_INSTOP_INIT:
 		if (req->ctype == NIX_AQ_CTYPE_RQ)

...

-- 
pw-bot: changes-requested

