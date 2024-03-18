Return-Path: <netdev+bounces-80310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA7B87E4CD
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3161C2026E
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 08:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531022576B;
	Mon, 18 Mar 2024 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/QuOR6w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B724B26
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749460; cv=none; b=O8TQQBYQCTO97b6wqWxjY22uTjGqgxcDAFlq32XDRf/SImUV2XLB7rqoqhJN9yHirvUKAC28MZWoFGJOxg3zFUZtaECJDQFbzjdNPZrjGiQutO7EFdA2XjYYVy/p21Et253y3stVbxGxzZNPRDpzDS5Oa7TvJt7WfnjqPLtfUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749460; c=relaxed/simple;
	bh=opmeh9JyNTU62HaqhKhjZQzYJINRflOWclmPToSuOvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIDpxOzqp/5FfRiWfIL/CYUps1D8h/9hi+9FzM82AhVLTB59DKy95C2+N8loO42VCqndhEOAznDrvX2yF2691R/INxgFGGZPYwAhS1tXyw5CNW6FGORucOZymj6vpEOhFw2UzaWYtdp0yw4DAOLqInJ6zehyRVlUnQ1bjEtYbYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/QuOR6w; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso4938821a12.2
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 01:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710749456; x=1711354256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E4DNi1tThxPrAjwj3MNLTkspc0oafwDCMGAENKTid3c=;
        b=j/QuOR6w9TSdjgU1TlaZerDTlRnKi4MwLIK6OD5Z6wf5Bi6Lc23Uy2w4CBDNoheNoi
         xNliQLXJJTvrCjWG3Mz9BEKmHl9awVjwFYCU7pRVoj/uwifDQ9252CK35c9D8BDyuClr
         XiM1/j/Dcx/tfo8bR62SWXBq4/tJyOVN6cAwJC1Evut9WeJaDFY7a0SfQ8pP8oAbC1Zk
         Y5xlS7pDOFqnFej6ulWXp7ncnwgzFHdGEFV7vB4jbTVD+aHD6E0cUX3iNOeLMiVW9Hy+
         hlmZmLlOQnbfsZGqcrctcKfl7ejBP67mUFItk39yw5XTnNIMxK53mIg1/YLWTbdorixk
         qqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710749456; x=1711354256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4DNi1tThxPrAjwj3MNLTkspc0oafwDCMGAENKTid3c=;
        b=TJaBzLkuirlq1/ah/y4MNDmpd34Ytwp3MIh3SRP3sf8R3WiOgzp3QwTy1gca60czhv
         8VV8CcC+r2nuWc/UJF9vE5BOV76CK0U5/mW3nlMdt+Ggl7W43U3QgsueAVPbThvBN8fV
         EY9TSS9Q/+cMAse94IgoZzfgg/N9xl+w3r3OxXybU5KGuA9KWUtjKm+TZT+SKlSKE/AL
         hOo8YFFDI/9pqrNAeZOSQMeXT3vTwk3haQ7FNxG/hOdnzYNOYeDC/DId5cZR51ga8Rjj
         qpcq9cC/EisWcZtWFPMBSU/Rxy1DOZrz4md5dWLRfvaEIx0w4/CkhFOx3c4VmG4sTQ/+
         k3ew==
X-Forwarded-Encrypted: i=1; AJvYcCVY3MxP5fycExt3GyFCGclFyevGxab+BAVuSU57BWx9mObM7UkKtEjXJnD60l6NtdB1mehZSVIEaw7rc1yH8aO8pT+PVZq4
X-Gm-Message-State: AOJu0Yx6aBEIK5bjGRbazWfCoVS9vl6MGiSA94WL6at7XKSPyK0MXbNy
	cwLkpyMQboezXD6L6RkEhRLQ7ybPhEGn9Iw9a2dIEtZuFj4nl07ygaYevKWF8a0=
X-Google-Smtp-Source: AGHT+IF7QDTquWD+I+K+G6iw+g4y541SJ1nIcz4EIs4ACVb80u6p6Zv/G7HRDxnFSFtqQ8VONOtvKQ==
X-Received: by 2002:a17:906:ca17:b0:a46:cef3:4aba with SMTP id jt23-20020a170906ca1700b00a46cef34abamr125127ejb.75.1710749455840;
        Mon, 18 Mar 2024 01:10:55 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id dv22-20020a170906b81600b00a4658d3e405sm4531600ejb.196.2024.03.18.01.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 01:10:55 -0700 (PDT)
Date: Mon, 18 Mar 2024 11:10:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Message-ID: <a315177e-a9b1-4110-a176-8a909335c56f@moroto.mountain>
References: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
 <Zff0IO6nqpMiGXl5@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zff0IO6nqpMiGXl5@nanopsycho>

On Mon, Mar 18, 2024 at 08:58:24AM +0100, Jiri Pirko wrote:
> Sat, Mar 16, 2024 at 10:44:40AM CET, dan.carpenter@linaro.org wrote:
> >Automatically cleaned up pointers need to be initialized before exiting
> >their scope.  In this case, they need to be initialized to NULL before
> >any return statement.
> >
> >Fixes: 90f821d72e11 ("ice: avoid unnecessary devm_ usage")
> >Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> >---
> > drivers/net/ethernet/intel/ice/ice_common.c  | 4 ++--
> > drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
> > 2 files changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> >index 4d8111aeb0ff..4b27d2bc2912 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_common.c
> >+++ b/drivers/net/ethernet/intel/ice/ice_common.c
> >@@ -1002,8 +1002,8 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
> >  */
> > int ice_init_hw(struct ice_hw *hw)
> > {
> >-	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
> >-	void *mac_buf __free(kfree);
> >+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
> >+	void *mac_buf __free(kfree) = NULL;
> > 	u16 mac_buf_len;
> > 	int status;
> > 
> 
> How about similar issues in:
> ice_set_fc()
> ice_cfg_phy_fec()
> ?

Yeah.  Sorry, I'll resend.  Smatch didn't warn about those bugs because
the sanity checks are the begining of the functions:

	if (!pi || !aq_failures)
		return -EINVAL;

are never true...  It's the first time I've run into this as an issue.

regards,
dan carpenter


