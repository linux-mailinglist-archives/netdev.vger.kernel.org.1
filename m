Return-Path: <netdev+bounces-38147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FB87B9926
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D03FD1C20905
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A6919F;
	Thu,  5 Oct 2023 00:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPyY2iNz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8654E7F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180FBC433C8;
	Thu,  5 Oct 2023 00:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696464723;
	bh=+UyJWMaNH1AUPWyvVuUGoF38yipYqRog5d+Zus3SXHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vPyY2iNzg5IRl97KQu+84CyCKjIt54IQOvY6hvaUH5AA2xfPx/oE99/An0zc1oqpz
	 /sDLtwSAz9Y+7jGvaY4NV/9rsHbz/WlW64B9vsnbEZi3A1bT4yP3P581oOdYcVlZZF
	 NRmVAsa/if6meZJjGnvNDRecHtv4X5gTUw6wCDYQaye9j3kA4w1Fhqpb5E7DH3P5dc
	 CymZcVkxE/a8SQcyhDtLL60yuJ5S246aghJ4D6RqhRL1ZQNRZ+H/iU82tAD2otbOSo
	 o2pBZOcBDO8miAmBRfsiAsvuO7n3pVRWJQbFkZxwfC1FPJKRiAVGEolrNVcQp3MnqU
	 88WcmeCbFcW5w==
Date: Wed, 4 Oct 2023 17:12:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, donald.hunter@gmail.com
Subject: Re: [patch net-next v2 1/3] tools: ynl-gen: lift type requirement
 for attribute subsets
Message-ID: <20231004171202.6e52bde3@kernel.org>
In-Reply-To: <20230929134742.1292632-2-jiri@resnulli.us>
References: <20230929134742.1292632-1-jiri@resnulli.us>
	<20230929134742.1292632-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Sep 2023 15:47:40 +0200 Jiri Pirko wrote:
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -723,6 +723,8 @@ class AttrSet(SpecAttrSet):
>              self.c_name = ''
>  
>      def new_attr(self, elem, value):
> +        if 'type' not in elem:
> +            raise Exception(f"Type has to be set for attribute {elem['name']}")
>          if elem['type'] in scalars:
>              t = TypeScalar(self.family, self, elem, value)
>          elif elem['type'] == 'unused':

Can this still be enforced using JSON schema? Using dependencies 
to make sure that if subset-of is not present type is?

