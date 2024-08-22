Return-Path: <netdev+bounces-120773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEC095A942
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 02:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FE01F226B6
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBA4524F;
	Thu, 22 Aug 2024 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj0Z5JL0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843D3FC2
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724288288; cv=none; b=E5hZuiZ19nTVA9iqKUD8CffK+bgtDnFgEahqi2Lh/IzEYAi0Ldb3DDGpJrT7vbGDGBYRGW7NrMXfV8CNDaRmVrp/5/Go3T6Ao6VK+CaxYI8p8nBUaBb9KJuGpVWqup4Rj8fHLDVwmob0/th1bLmbM3SBJLazxdBHEkowkG3Yq1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724288288; c=relaxed/simple;
	bh=Oe9pGhfIFUHB0JznnumfUuhKv0jKzerkYc9ylvLuOI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8xZ1hwTz+ccclwkCI0I6GJs71dwT+uZe6JmjHfbo4osBctAMGi58vDKHH2cCIG5YsAtZcx8X1S68fxxhqTLQEultzaCL3qMlX2LlEyjOzSCm5jwq5OZfarN1vh1lQwKJ2r0ZIGgudL5DHpOxR4K5sXRXnYhiAxd5gqqTk7rA6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj0Z5JL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA049C32781;
	Thu, 22 Aug 2024 00:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724288288;
	bh=Oe9pGhfIFUHB0JznnumfUuhKv0jKzerkYc9ylvLuOI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fj0Z5JL0FSzpQnVQQ4je326ISrzLh5YZ327NX6Jx2N6LFB484DBmyhIyM1R+ynpFG
	 49MYkqOEmCnS2lS1syXm5KxY2aqGbWXBXI7b8OpyrSA8TUCKDDZotMrXH1Kem1bs32
	 I1Q+hVGUblw/5RzzPI3p4jb2Wfb0ULovZ/4IROPiGOqcEYK4HA9TIdsGahp3oK7N7F
	 bfv4puL82Amzc8GrDa79USmiWLO8AxX55vrL95V5i34/MDOyJHFwzTj4fV7lyj43qn
	 a6MElKBIwxMiuEydwmYz/CKHFiluLlkjdLBIc1rXcAT0mKZFGSuUrVPOShxGpgsboT
	 pmIbNzc2xrH3g==
Date: Wed, 21 Aug 2024 17:58:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH v4 net-next 00/12] net: introduce TX H/W shaping API
Message-ID: <20240821175806.23878bae@kernel.org>
In-Reply-To: <cover.1724165948.git.pabeni@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 17:12:21 +0200 Paolo Abeni wrote:
>   tools: ynl: lift an assumption about spec file name

I'll pop this one in, no point carrying it around.

Double check other patches for trailing whitespace. There were some
warnings when I was pulling the series in.

