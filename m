Return-Path: <netdev+bounces-198216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D169CADBA9A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB4517441A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8EC1FBE9B;
	Mon, 16 Jun 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdlBqKzH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6DF1898E8
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104791; cv=none; b=HG8bWT5tVjO1v7isBLTPH8svoevLH5dBUh5aOkg7e03Twspfg70HfRapLrtd2GG6jjKZ2C3A8ZHnQ8fh6hMg63ArDLEliY2F5+ZnASC3xbWEWY0nqdyQZfPlqGEFnZu+SJBkb7zBBlS6wiClNhWMXseP/ud4P50lDY/pjYgU5Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104791; c=relaxed/simple;
	bh=nlh8J7Qun1pDJlyZjl8w8zo9XjfixAWLTNiff0nzJ6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Or2T2hkjumNa8x1p3yGicWz4CtwFkwl3RwjT3H2rEwpO8SGbeTKEqAyO1nE/uBHD3TUGA8MoAV/EqrCueoZVi+JmbW084LmOwATBpxtsfKJ/FUzmyXO/hq0WYtPvgbqjX68s8yKDpWXnyuSfaYS6xEZHHeYWF3LfLuWRow9q2mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdlBqKzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD91C4CEEA;
	Mon, 16 Jun 2025 20:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750104791;
	bh=nlh8J7Qun1pDJlyZjl8w8zo9XjfixAWLTNiff0nzJ6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tdlBqKzHHyiLzvA9VxJKqnHWDxeqH2DlZc/v1CRbH9OhPFC0jgw739L+hKnDKPWqN
	 +QEdukHcRTm7VmeZ4MP8VZ14p7LXm/Z71lQ8RBPPqiyg73qi/MywZNonQKydGq1aYt
	 yN8on5VQwcnCbQLSOs5oIzXu2d0j42EM9tRMzog/Nb7M25hT8b0YIRRkExNTPZVnN/
	 JwFFAljKyjspFZimjcySdZ6vrqx2KgGzPrys0R4FPC399IZ5H4a8ZiJNO3Jbwf/kaj
	 VMGCP7aj1JoM7423F1Jtg7Kap+u1nRaMlMdSdygj6cIBl/UCAOJqt+O38w9QwltdKf
	 rvKgYgLpMnDYg==
Date: Mon, 16 Jun 2025 13:13:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Neal
 Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net v1 3/4] selftests: net: add test for passive TFO
 socket NAPI ID
Message-ID: <20250616131310.61c99775@kernel.org>
In-Reply-To: <20250616185456.2644238-4-dw@davidwei.uk>
References: <20250616185456.2644238-1-dw@davidwei.uk>
	<20250616185456.2644238-4-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 11:54:55 -0700 David Wei wrote:
> Add a test that checks that the NAPI ID of a passive TFO socket is valid
> i.e. not zero.

Could you run shellcheck and make sure none of the warnings are legit?
-- 
pw-bot: cr

