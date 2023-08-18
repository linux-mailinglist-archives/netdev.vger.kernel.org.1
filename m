Return-Path: <netdev+bounces-28837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835E5780FA4
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 17:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E981C2160D
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 15:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A54198B3;
	Fri, 18 Aug 2023 15:55:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01C2171AF
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 15:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D54C433C7;
	Fri, 18 Aug 2023 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692374136;
	bh=Lhju2ZaN7gR36zx4tgh0JwAntyBiSExj0D9zkg1jkS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cFaD+eiI0WRMJY4kG2SzeLS2KbZRWYDpP/vnoyHKU+xSI7d4IEZpo1DPop5zMr+sC
	 r/jDEHu2UDk+MOmfotEhyzTJgcTFILrgsIzUrbNiJmcGz9kiTZhPhyTKlgY/zkCi86
	 6WGK7atYyBgsNuFAPTt5yvcC7MQzfmANhbHooDLwHwzaEwmsezZfboumS6MfQPcAtZ
	 XlUcLvCgMTqnM2ZiUcPbTLJl0gm/1//UeVdGSfcoTaltiKB/ZEGYlXTMR45sUFR6yR
	 UcLPds+cxKVqWh6Hzs7jwXZv4NjYyINLN5GsfQcb+r7jg/MFEu+V6Lu3zgI/e3QkCZ
	 nzhfDuVzOqa2g==
Date: Fri, 18 Aug 2023 08:55:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: Re: ynl - mutiple policies for one nested attr used in multiple
 cmds
Message-ID: <20230818085535.3826f133@kernel.org>
In-Reply-To: <ZN8tv9bH1Bq8s7SS@nanopsycho>
References: <ZM01ezEkJw4D27Xl@nanopsycho>
	<20230804125816.11431885@kernel.org>
	<ZN8tv9bH1Bq8s7SS@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Aug 2023 10:37:19 +0200 Jiri Pirko wrote:
> >I'm not sure if you'll like it but my first choice would be to skip
> >the selector attribute. Put the attributes directly into the message.
> >There is no functional purpose the wrapping serves, right?  
> 
> I have another variation of a similar problem.
> There might be a different policy for nested attribute for get and set.
> Example nest: DEVLINK_ATTR_PORT_FUNCTION
> 
> Any suggestion how to resolve this?

You mean something like:

GET:
 [NEST_X]
   [ATTR_A]
   [ATTR_B]

GET:
 [NEST_X]
   [ATTR_A]
   [ATTR_C]

Where ATTR_A, ATTR_B and ATTR_C are from the same set but depending 
on the command the nest can either contain A,C or A,B?

That can happen in legit ways :( I don't have a good solution for it.

