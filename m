Return-Path: <netdev+bounces-121058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB795B86C
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EEBBB2ABA1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235A41CB329;
	Thu, 22 Aug 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VT3u47Yj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18AE36AE0
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337026; cv=none; b=PHK5cqj5KnoSmjvxWbO2loe1o+rBLUEXePTeWAKI0ezuUECXVz54Gr+5RWyyCFEZaHt06Kn5pL0NA+renxCBEH1+D4nBM0EOCs4A9sWJrUkaJVIXcKFrBWyXCwEFzReLPCggU9TFQVImMNSPoXou1keU5VaVctBdLteorEroO+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337026; c=relaxed/simple;
	bh=jn506kOABGogquftoPFGSqZkTv7WWTTZWicv78hgAO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVEiOxEO/9kFG8aBcL3dL7I8gWZo6Djh8H6CKpAe/40gvHb/S+8/RM8zN3ct7Eyx3P8cbvcYqUXRmPnxg413UfbVTEbziiD7nP+FV/dzB19qkMhiR8JkWkTFYaz+O6uImViv8n+LTmFDkEK1X7p0Z8cKszp8feauRrwLX3iKnQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VT3u47Yj; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-533521cd1c3so744396e87.1
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724337022; x=1724941822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0AOgkHsmxrrYPyGQ/4+OtViWpYvO8BCZysRgvY+GiaY=;
        b=VT3u47YjR9IGyU/jMgtDEW/hHHCJ/rTIAc07//ewslcvK5Sg+rcgMcNnN4sPJNHpYn
         DcoqBv1/Tp5RTNFS52dE+Z7upK8swQGFlYY+8k8vTzYQofibOh3BcfYPkmmWGJImJLtm
         WHfc920OclE491CdLCKBTDS7MpdpF5QKGYfhnk1ZYhc5zrQEBiGjfe2SsXbq4DaC5UBX
         VlIwPWL6MP5zc/q4oCJQDXfyYf9JTCWYD32qYPQZYvRZFKPTCgduHVIedoUV5/x3rhnb
         69KkTdirdiZ7sI49DiEE6vvVAbG1WI+V1GuKhJ2zA+BDankuTBY4GVNthdmDt8r4iBnb
         jntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724337022; x=1724941822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AOgkHsmxrrYPyGQ/4+OtViWpYvO8BCZysRgvY+GiaY=;
        b=Zf1L1FSxqx4J4w60mxL/+RNJ2zN1HYjsNmfyEP9BdJbongl/kJtUrPbxt1KDMx6dfO
         0pPFmVyEMi//0XFY6SizoAFBMtxkGEdx1eW4C8v4Oh6/ARyrEWBoUyq24ydexqma+H/r
         yFPT9WvSavkrlDHJAb94tNUnC3F54lmgCpZsnaKwLZ+yOPMOOnqa0rzJIsnFT8IK6+yB
         llb3Wt/nBwdmA1by9kVbaWWbonjSpCViY0Vwd0ll6ERMrOifF1ZZ7u4Ij53r/+TApY0e
         cwkkO1qnaNhfxs4lWLAIuxf+JjZtqdyJx2DBNajRr1rXfbvNxGK2TCNi0lGEyPsgBz6o
         VD9w==
X-Gm-Message-State: AOJu0YzMqV0tWcV0z223ce0/VPXt7depGtEDE7+6PpeEbs6OLTnPOUKD
	4yYCCP9+Dqvf8VD/PKgjzytv8z5MJHzv6bbpJ5/JjVYb36B/0e8LWQjX+KU5QkQ=
X-Google-Smtp-Source: AGHT+IGSZcPc7HtL1sG19hUCiCBTwxU/ErZjo9Q2ro/3Je5UYCF2HgNJnsmS00Hm02ZgfSnuVdIs3g==
X-Received: by 2002:a05:6512:3c89:b0:52e:d0f8:2d43 with SMTP id 2adb3069b0e04-5334fbe593emr1904871e87.17.1724337021802;
        Thu, 22 Aug 2024 07:30:21 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484b29sm126444466b.162.2024.08.22.07.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:30:21 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:30:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v10 01/11] octeontx2-pf:
 Refactoring RVU driver
Message-ID: <ZsdLe-FY3bzzgU9v@nanopsycho.orion>
References: <20240805131815.7588-1-gakula@marvell.com>
 <20240805131815.7588-2-gakula@marvell.com>
 <ZrTnK78ITIGU-7qj@nanopsycho.orion>
 <CH0PR18MB4339720BC03E2E4E6FAC0251CD812@CH0PR18MB4339.namprd18.prod.outlook.com>
 <Zr9d18M31WsT1mgf@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr9d18M31WsT1mgf@nanopsycho.orion>

Fri, Aug 16, 2024 at 04:10:31PM CEST, jiri@resnulli.us wrote:
>Fri, Aug 16, 2024 at 03:36:41PM CEST, gakula@marvell.com wrote:
>>
>>
>>>-----Original Message-----
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Thursday, August 8, 2024 9:12 PM
>>>To: Geethasowjanya Akula <gakula@marvell.com>
>>>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>>>davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>>>Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>>><sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>>>Subject: [EXTERNAL] Re: [net-next PATCH v10 01/11] octeontx2-pf: Refactoring
>>>RVU driver
>>>
>>>Mon, Aug 05, 2024 at 03:18:05PM CEST, gakula@marvell.com wrote:
>>>>Refactoring and export list of shared functions such that they can be
>>>>used by both RVU NIC and representor driver.
>>>>
>>>>Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>>>>Reviewed-by: Simon Horman <horms@kernel.org>
>>>>---
>>>> .../ethernet/marvell/octeontx2/af/common.h    |   2 +
>>>> .../net/ethernet/marvell/octeontx2/af/mbox.h  |   2 +
>>>> .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
>>>> .../net/ethernet/marvell/octeontx2/af/rvu.c   |  11 +
>>>> .../net/ethernet/marvell/octeontx2/af/rvu.h   |   1 +
>>>> .../marvell/octeontx2/af/rvu_debugfs.c        |  27 --
>>>> .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  47 ++--
>>>> .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
>>>> .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   4 +
>>>> .../marvell/octeontx2/af/rvu_struct.h         |  26 ++
>>>> .../marvell/octeontx2/af/rvu_switch.c         |   2 +-
>>>> .../marvell/octeontx2/nic/otx2_common.c       |   6 +-
>>>> .../marvell/octeontx2/nic/otx2_common.h       |  43 ++--
>>>> .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 240 +++++++++++-------
>>>> .../marvell/octeontx2/nic/otx2_txrx.c         |  17 +-
>>>> .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
>>>> .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   7 +-
>>>> 17 files changed, 266 insertions(+), 178 deletions(-)
>>>
>>>How can anyone review this?
>>>
>>>If you need to refactor the code in preparation for a feature, you can do in in a
>>>separate patchset sent before the feature appears. This patch should be split
>>>into X patches. One logical change per patch.
>>If these changes are moved into a separate patchset.  How can someone understand and review 
>>them without knowing where they get reused.
>
>Describe it then. No problem.

I think you misunderstood.

You should describe the motivation for the refactor. Do the refactor in
a separate patchset, one logical change per patch. In the cover letter
tell what you do and why. Tell it is a preparation for follow-up
patchset that does X. Simple as that.

>

