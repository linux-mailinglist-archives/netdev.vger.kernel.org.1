Return-Path: <netdev+bounces-64083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8CB831036
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 00:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958EE1C21F90
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 23:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F9825639;
	Wed, 17 Jan 2024 23:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD6RtN0N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA4225A1
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705535746; cv=none; b=inRQHVAtVFu1iXSWhN+1GD4sE4xUjcGzElIJZdl271fkgNg+925cQbti4dK3bWbEeZsRCZtMFYFiNXxf9XWDFpYjy24PeTL4Dv9CMbEYQjjM+vopJdg2HT8Jkh7kKxYrrUPzRswxihlz8mbVvFj4WSzPhltpsbOALiKmKIixfhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705535746; c=relaxed/simple;
	bh=T8Y3QACDQncqULbvZxv+vhL16HAzKTMgzI1PwAfDFAk=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=LHiNQ4g+BVz6v8iTumrtcFzhujkk08xiwl/UviC/WTzD5I+z3SAK4x06RHG3IexkOyvQPULqvw2D2YPfkKGzvzxHoQvWB+oHxc+M2Q3mCqxTCmqb8qRnt4EeYovLS9nbxUfds0hJcnEsiKzyMAsEMDYVzGL5OsoTUtSSfV/NLq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD6RtN0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B17C433C7;
	Wed, 17 Jan 2024 23:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705535745;
	bh=T8Y3QACDQncqULbvZxv+vhL16HAzKTMgzI1PwAfDFAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HD6RtN0NTqnNRnF4auQvcAWpjuTOKASsYrpEz7fC+AqGFOwInXACk+651ItSYha4h
	 aUrqpRp4IGQglDIlSTEgpNXGaA0tqbptMaFx8+z/LhrhoA5cRZpQ1GEwQRgbwNqpMW
	 mswiOJSXLvc3083MPy93Xk1pEDkaWP5QoxKuOCIefpN25RfJ6XTK27Yw3aIur9kA4f
	 C6xfd/MyRhu7BIQ08jG/Btvcb7E4z/CUgGqHPOEkkk2LVqp1iStc1xL9s5fNXGFj2O
	 +vGceUIi/EIfhdsoiMVXriQNyBjAJUxee4piywdDph8gcKat219wAIkCjwu7dWUxR7
	 pOfIy4hs/TnMA==
Date: Wed, 17 Jan 2024 15:55:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
 manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
 skalluru@marvell.com, VENKATA.SAI.DUGGI@ibm.com, Abdul Haleem
 <abdhalee@in.ibm.com>, David Christensen <drc@linux.vnet.ibm.com>, Simon
 Horman <simon.horman@corigine.com>
Subject: Re: [Patch v6 0/4] bnx2x: Fix error recovering in switch
 configuration
Message-ID: <20240117155544.225ae950@kernel.org>
In-Reply-To: <dd4d42ef-4c49-46fb-8e90-9b80c1315e92@linux.vnet.ibm.com>
References: <4bc40774-eae9-4134-be51-af23ad0b6f84@linux.vnet.ibm.com>
	<dd4d42ef-4c49-46fb-8e90-9b80c1315e92@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 15:56:21 -0600 Thinh Tran wrote:
> I hope this message finds you well. I'm reaching out to move forward 
> with these patches.  If there are any remaining concerns or if 
> additional information is needed from my side, please let me know.
> Your guidance on the next steps would be greatly appreciated.

If there are any patches that got stuck in a limbo for a long time
please repost them in a new thread. If I'm looking this up right in
online archives the thread is 6 months old, I've deleted the old
messages already :(

