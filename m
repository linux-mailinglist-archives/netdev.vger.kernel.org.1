Return-Path: <netdev+bounces-131853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C340198FB8D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 02:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7670F283154
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C3C17C9;
	Fri,  4 Oct 2024 00:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZxU6//0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F61D2233B;
	Fri,  4 Oct 2024 00:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728001930; cv=none; b=b2AwDlsJ8T6GfeWLY1lLYrh3BWesFZoBXlxUJF7MMTg/sCJK4skLgzJcbKIxNVtVzyCsroAKB5pCF3n7WM0SNRYB7yP5E1RWq7irNRKqm22ATMZmwaJrTEX9zb86M8Vcj+cRh67hkul3gmo8iLmz4dQt+naqWo3ziIq/aSsusBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728001930; c=relaxed/simple;
	bh=0euF5hnFLXpDZPkAgzy4pr7Yli5RFu5Rd+Pthg74fUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZ9Bdj7T+YFsG8gagOO5hp+v1iVpPxm+KBRDfG4hQOknf2F1xGEQwR7kyeXxHHWXDhz5GQKlxYBr2QXjnaQQHwlWHlJP9PKU1wcDwAgiuos8hLMYVyOM0LBL3SXeWMKgGBEVWwb1vnYE05MS/DBWqffoFzAe/dbPpL510x7MeDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZxU6//0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B001C4CEC5;
	Fri,  4 Oct 2024 00:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728001930;
	bh=0euF5hnFLXpDZPkAgzy4pr7Yli5RFu5Rd+Pthg74fUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HZxU6//0Q6wgdA8SCfIYM4w3FUtPHKOnF7Q6lO49wvmA7FnPexajJiDruNaBdCNLl
	 Zu6U0fB6vEAuOrw4oVNtid9tmYJk0vMJOCivFj6GYcT64r1YS4yAA0RKJ9t4dyuzmv
	 CVzML6RdjaTAy2nqtDtMdPPDb1Ex4z/gqaWUNZzUx6cJwxRmi4DIl/shBM1dyYhYkV
	 adJx4gEL5RUYJs6lFHAHCBw5itQWa+aMeEpaaTKHeaJSmfEReIoxqUWI34aRlSBIZS
	 sGMFyfyxBE9+E60Ea37u2LJdOgeDpTkQ953NKBAf7bs+DmGqPrI8VJNpdhXzZFpeW7
	 DQJ6lGXhFbpMQ==
Date: Thu, 3 Oct 2024 17:32:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [net-next v2 1/1] idpf: Don't hard code napi_struct size
Message-ID: <20241003173208.553f0cfc@kernel.org>
In-Reply-To: <20240930162422.288995-2-jdamato@fastly.com>
References: <20240930162422.288995-1-jdamato@fastly.com>
	<20240930162422.288995-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 16:24:22 +0000 Joe Damato wrote:
> The sizeof(struct napi_struct) can change. Don't hardcode the size to
> 400 bytes and instead use "sizeof(struct napi_struct)".
> 
> While fixing this, also move other calculations into compile time
> defines.

Anticipating v3 with smaller diff based on Olek's suggestion so:
pw-bot: cr

