Return-Path: <netdev+bounces-205825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681C7B004DA
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 16:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377625A05EE
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 14:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0964327147D;
	Thu, 10 Jul 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6JAkrz2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A0C125B2
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156548; cv=none; b=MWQjgzN6Y6rZezKBDgq1LoyMZXwkt0q8G035g7RG8ddzuLctjfIUj+o0ECkXnoooXtoIAOeWpEIhPeeup3AfrDZrNXM4rH/eNvsGjTvB2fODq0YUE4AeIUztzBgP1ZvFo7Q9iM1oDMSgjCqb50B6/8eMp+VeELnqeqNI786QSfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156548; c=relaxed/simple;
	bh=PXB1BoExqsV8a/+RJWqWKnj8KGOC4drXYslc3f3GlyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qY7p1phZEeGCJrFZwSjMhfE8FHlvjwmG5wlD1wko+DyzlE+H6PRhuDKKBl7oz/C1g6tGWRPLeIIPsn8CaqilNvR5lNtGPmjO0Bbte8XfGztUidP23YHcx4TgufbpFzYOLe/Ga19l+gBUhXDbTMiWYaJEnXFfsF77FFueV7VHVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6JAkrz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A1DC4CEF5;
	Thu, 10 Jul 2025 14:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752156548;
	bh=PXB1BoExqsV8a/+RJWqWKnj8KGOC4drXYslc3f3GlyQ=;
	h=Date:From:To:Cc:Subject:From;
	b=Y6JAkrz2JL8shEhW7HjBG0onhSEmUQn7o0YsTwdqYJ6z88LAetLRj9IeaeLI1W7m+
	 qfQjhAJ//1oDFqTkRfy/NpSb6LVUzKbzB8yd6zYV9RtpB/apqZC53l+WuNko+fTzAd
	 qmfP3fqWagzF+X1ZgwkfdizsVUhlleFzTr7vol/qHeIYx81wPVe4YjifCO8LZl1O2I
	 NVPoCSd33stcFXBn43YLhPWvKKs/jpkiY+Yksh0/csWPUA6Qn+HxaQzQ2GuWy8y+WM
	 lCxRhpp/7qf2CPhEfUPwHJ1jRMDZIN1UtgndXL0OKF+zBVhFESYZRF+j4sn7vuOBWy
	 AXNzHLp1lpwjA==
Date: Thu, 10 Jul 2025 07:09:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [TEST] net/udpgro.sh is flaky on debug
Message-ID: <20250710070907.33d11177@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

net/udpgro.sh has around 6% false positive rate on the debug kernels :(

Please see:
https://netdev.bots.linux.dev/contest.html?executor=vmksft-net-dbg&test=udpgro-sh&ld_cnt=200&pass=0
for recent failures.

Is there anything we can do to make it more resilient ?

