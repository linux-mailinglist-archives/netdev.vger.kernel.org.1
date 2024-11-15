Return-Path: <netdev+bounces-145489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E719CFA53
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBAC5B38BB3
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975F1191F83;
	Fri, 15 Nov 2024 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+UonLEX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6614F190692;
	Fri, 15 Nov 2024 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731710293; cv=none; b=B7fDuUZTqxtK6CcEb8U1zCxfm6bKmDcdDjkcToL7WVrOm4TPbtrnsL6w8+S61ctupGrq4jsbZxWm6AWWeV+Wc1tYblYyTqYE5OOR3ozv5vvNcJ2WIhrD/imXdTonKFGBO0GBKpkX9IIGeFLEzxjwa/mzMBWIzeBUZB2qxiia+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731710293; c=relaxed/simple;
	bh=90WobDr6fY5FbA3HP88dL0T8xywHqLPOmQV3gW0EKvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3w5pktZaQNrywhCEAImVpFLH95tBmlyLUipoTjylojlzIC5KtGmf5JaXgET+mGqI+O7p6SSn6cXubzKGYIjz4YFrGL7vXQWxqvFwOdO/l7tX7IJvmwt/6CbdpE8d1rQy6NNlatJVErl4nOyJcJxMJZ1kj5WJ3EN1pMSrCJ5EKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+UonLEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4B8C4CED2;
	Fri, 15 Nov 2024 22:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731710293;
	bh=90WobDr6fY5FbA3HP88dL0T8xywHqLPOmQV3gW0EKvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B+UonLEXHnzU86Wry9yH0YtjDzvNcQ8AG54+ieJ66sQ5gWYhffJ1xufUbQvF1xBmz
	 AaYsYQgFoGup0nTlWfL6hwrxz5Aw2dZgET9XAhykr8YHYp3bhGuSbJ1NGhiFQdx3Ml
	 elHL/VWrY3xT19scYMwTcmMEBqzIsqH+bYApso2LbWQxFk8mLhx5QVYdad8uDEsFfy
	 siNm2XgjxBmMmQp4zTNvDWdncLgwLqj7CWr/mO20pSzVDjG4vSQRIwjmbyTn8hY/tI
	 7Zk3mM1eVXNtyqfmY+nrm9sgCBYqX/uh/8BQ1vcW6IloepUGWPrDSA1eypdSzPa1BN
	 2aCMIeo7IqzMw==
Date: Fri, 15 Nov 2024 14:38:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, horms@kernel.org, corbet@lwn.net,
 andrew+netdev@lunn.ch, kory.maincent@bootlin.com
Subject: Re: [PATCH net-next v2 3/8] ynl: support directional specs in
 ynl-gen-c.py
Message-ID: <20241115143811.253bb780@kernel.org>
In-Reply-To: <ZzfDWB1O_mgF0o7j@mini-arch>
References: <20241115193646.1340825-1-sdf@fomichev.me>
	<20241115193646.1340825-4-sdf@fomichev.me>
	<20241115133244.6e144520@kernel.org>
	<ZzfDWB1O_mgF0o7j@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 13:55:36 -0800 Stanislav Fomichev wrote:
> > You gotta say "Message enum-model", enum-mode alone sounds like we're
> > doing something with how enums are processed, rather than message IDs.  
> 
> "Unsupported message enum-model {...}" ? Will do.

SG

