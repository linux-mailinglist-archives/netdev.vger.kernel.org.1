Return-Path: <netdev+bounces-100277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B178D861F
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FF21C21409
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E1412D205;
	Mon,  3 Jun 2024 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImVQK+zW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6891292FF
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428837; cv=none; b=MqwxEDPPgIEUtq0cMADyyTMG6dLJeIOtEHSzHHmbFCRdm9V06ifnrU5Y1Q8A77wc0qxrrMcI2UtvkTAvywRBHrnmi69TKU8/iH6/t9FlvAuYsaZN00ZZyll5QeQwgo2tA7YMJCN/5vj2ocQHhNgQjja2Ikyg9nBFmDTBopVl0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428837; c=relaxed/simple;
	bh=RWgQzSiKwz+soRrVxETfYHRexxx/WGvMka/7e/m21FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0CKuMWWgKeKKIJczM+yfeKwACwtU8jFnzbzE/qqRuAhJHfk6RlEn1YYsYgzvcONy+L5uxe/R10KeEwBFATBC1AWksCC8hXnVn4bHmyNOCLRu8kxx3UtyzWoalFD+gAfgIoEwCM4QLl3aDDP4k0yX75IP8I+BzF8XXQ+Tk95yVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImVQK+zW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBA9C2BD10;
	Mon,  3 Jun 2024 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717428836;
	bh=RWgQzSiKwz+soRrVxETfYHRexxx/WGvMka/7e/m21FA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ImVQK+zW0ctIl9A/pUTNffkfSV5RQyJKvgt5F6QjKpSDj4dMR2snaR64YNKOK+XLR
	 l5Q4OaWWMTHqBmMluB0TbI6/P1p/hHomWXwc3PMG3dYtndrHsX5SHgMTKZH8cVQJkn
	 53dzdnYIaxfMCwpSqow5JhrI/KJe5SRir0eOsPeTKB+aGVahsC8aIQ44ZSv/IQ1t9C
	 QX5DqJ+xz27gozNLggfBZ4kvHUas6JhUvxJ1W9lpp7Dhj12/8QyXceCNXo8aUe2w2a
	 klg7qtW1ryQO5ZzJbqcU4QlmSDtOdmrrhCu3Ixx3VcxQG1zdffR0LBlhNdSQBYPWff
	 TUYToXQIigKIg==
Message-ID: <7fb14a5e-0283-4551-a284-98f6d9ce02fb@kernel.org>
Date: Mon, 3 Jun 2024 09:33:55 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() in
 inet_dump_ifaddr()
Content-Language: en-US
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
References: <20240601212517.644844-1-kuba@kernel.org>
 <20240601161013.10d5e52c@hermes.local> <20240601164814.3c34c807@kernel.org>
 <ad393197-fd1a-4cd8-a371-f6529419193b@kernel.org>
 <CAM0EoM=jJwXjz3qJoT21oBsHJRCbwem10GMo1QStPL7MtUwTjg@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAM0EoM=jJwXjz3qJoT21oBsHJRCbwem10GMo1QStPL7MtUwTjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/24 8:05 AM, Jamal Hadi Salim wrote:
> 
> Sorry, being a little lazy so asking instead:
> NLMSG_DONE is traditionally the "EOT" (end of transaction) signal, if
> you get rid of it  - how does the user know there are more msgs coming
> or the dump transaction is over? In addition to the user->kernel "I am
> modern", perhaps set the nlmsg_flag in the reverse path to either say
> "there's more coming" which you dont set on the last message or "we
> are doing this the new way". Backward compat is very important - there
> are dinosaur apps out there that will break otherwise.
> 

NLM_DONE is not getting removed. The recent changes allow the end
message signal without a separate system call.

