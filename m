Return-Path: <netdev+bounces-73094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E4F85AD76
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 21:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859B61F2516F
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3826D535A4;
	Mon, 19 Feb 2024 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbmOPxsK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133791F18D
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375756; cv=none; b=SqpbY0DkdIZUgTzmu3tiNwZUILrheiwyPeecVBN6NmFZARakJXJmUWry8L9XvLAw1Gdfy0mqoGUe7eouTothZCQ5SaLtOuFxz58TteRwlUR1bugPIsxlhzSx6nO7pWX3/e4Z5Q7OONCLM3UMRfnLvJZ1IYOneALf/Nkboh0aXFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375756; c=relaxed/simple;
	bh=9oRn40MG7ljImydEDL+mK9s72hHmlWRmGLf6hhBRQ6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnnUS4QVCW1sp3Zd5TizmHsh/48wqaTRjG9UKJK+1RICtsUFs24zxdt/I8KbPWSCYZbQCnCqLhze8QcScMNnx+dzWPw3wRMVSnScN4HSk2wglC5TymRpoKjjib/O5COHlITCpe6pJzNGe73S2ocyLoZiHUZu83OC3n1Q7G8T7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbmOPxsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2F1C433C7;
	Mon, 19 Feb 2024 20:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708375755;
	bh=9oRn40MG7ljImydEDL+mK9s72hHmlWRmGLf6hhBRQ6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MbmOPxsKDhGf3AAvaiUMPp9sTDcITb/LlZEKvUTnVO9UhDfWlLJ9FBCHe0cDnQM8n
	 htrhOG/FXx9egG3WDN74LDtAnqNG/HnhVv4CXmZm0395R+rBlzDs0Px4Oczy6ni00/
	 8jYjACTKEslHOr83mPSpL9cxUL9JgSfywUn3lDoTJgudqG0a10I0MbUaZr+KmXefwB
	 zNrD6xg6VsNLbKboy5i8oqtlvPsbNgadFRx+W2kn+8GQp1FP8Mzh61fG2u5Npkzbg+
	 sJ0zqfOJG7/qMCa06hSgKifUakstHJAt/RxCamNwGoNtETMCyjBFzpXe2w222cv0Oy
	 nFt2lg78Y/AZA==
Date: Mon, 19 Feb 2024 12:49:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com,
 swarupkotikalapudi@gmail.com, donald.hunter@gmail.com, sdf@google.com,
 lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 03/13] tools: ynl: allow user to pass enum
 string instead of scalar value
Message-ID: <20240219124914.4e43e531@kernel.org>
In-Reply-To: <20240219172525.71406-4-jiri@resnulli.us>
References: <20240219172525.71406-1-jiri@resnulli.us>
	<20240219172525.71406-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 18:25:19 +0100 Jiri Pirko wrote:
> +    def _get_scalar(self, attr_spec, value):

It'd be cleaner to make it more symmetric with _decode_enum(), and call
it _encode_enum().

