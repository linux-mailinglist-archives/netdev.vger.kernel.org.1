Return-Path: <netdev+bounces-154255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145479FC53B
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 13:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15CF163C94
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 12:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1328C167DB7;
	Wed, 25 Dec 2024 12:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03FD17993;
	Wed, 25 Dec 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735131027; cv=none; b=nTC+cK9uO0fHuYVG4xbz+Ake8Iszb1srHLfFDzgjz7xFRLga8fv6lO3NQaj01ziucxAfaRDN+j82+1P7ZV+72P6nDTSTo/MNjbLOC5tO0Muh3zDMY5HYC/LAAezaPaDHkKchhoNCL5t27kJn+Fl1/sdXAOTBWhyr82slyvzPpoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735131027; c=relaxed/simple;
	bh=md9henrb++nlnxxKMr+DbB9p8KksrXQXlvv0y61YA/4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=quIhchIYLOVliEd9BVNmjxDoY6FmkWkrcPdA0zqk35vUySMV/iqr5lFnezGQ2Tmr1EJPihOgovGO8KbSELYI3G6s5L5XTZkxyQbkFULV9smoQOZ+RB+foklHj/Qew8VIcgI5GZW9M1xHRip26bF7nuDxEd9DCp5/WzA6mbobqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5ddd71dc.dip0.t-ipconnect.de [93.221.113.220])
	by mail.itouring.de (Postfix) with ESMTPSA id 49DFD11DD44;
	Wed, 25 Dec 2024 13:40:30 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id E9EF060191736;
	Wed, 25 Dec 2024 13:40:29 +0100 (CET)
Subject: Re: [bbr3] Suspicious use of bbr_param
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4616579.LvFx2qVVIh@natalenko.name>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <4ea88dcb-6328-233f-eddc-1fe49313c3ab@applied-asynchrony.com>
Date: Wed, 25 Dec 2024 13:40:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4616579.LvFx2qVVIh@natalenko.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2024-12-24 22:04, Oleksandr Natalenko wrote:
> Hello Neal.
> 
> One of my users reports [1] that BBRv3 from [2] cannot be built with LLVM=1 and WERROR=y because of the following warnings:
> 
> net/ipv4/tcp_bbr.c:1079:48: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
>   1079 |         if (!bbr->ecn_eligible && bbr_can_use_ecn(sk) &&
>        |                                                       ^
>   1080 |             bbr_param(sk, ecn_factor) &&
>        |             ~~~~~~~~~~~~~~~~~~~~~~~~~
> net/ipv4/tcp_bbr.c:1079:48: note: use '&' for a bitwise operation
>   1079 |         if (!bbr->ecn_eligible && bbr_can_use_ecn(sk) &&
>        |                                                       ^~
>        |                                                       &
> net/ipv4/tcp_bbr.c:1079:48: note: remove constant to silence this warning
>   1079 |         if (!bbr->ecn_eligible && bbr_can_use_ecn(sk) &&
>        |                                                       ^~
>   1080 |             bbr_param(sk, ecn_factor) &&
>        |             ~~~~~~~~~~~~~~~~~~~~~~~~~
> net/ipv4/tcp_bbr.c:1187:24: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
>   1187 |             bbr->ecn_eligible && bbr_param(sk, ecn_thresh)) {
>        |                               ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
> net/ipv4/tcp_bbr.c:1187:24: note: use '&' for a bitwise operation
>   1187 |             bbr->ecn_eligible && bbr_param(sk, ecn_thresh)) {
>        |                               ^~
>        |                               &
> net/ipv4/tcp_bbr.c:1187:24: note: remove constant to silence this warning
>   1187 |             bbr->ecn_eligible && bbr_param(sk, ecn_thresh)) {
>        |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/ipv4/tcp_bbr.c:1385:24: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
>   1385 |         if (bbr->ecn_in_round && bbr_param(sk, ecn_factor)) {
>        |                               ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
> net/ipv4/tcp_bbr.c:1385:24: note: use '&' for a bitwise operation
>   1385 |         if (bbr->ecn_in_round && bbr_param(sk, ecn_factor)) {
>        |                               ^~
>        |                               &
> net/ipv4/tcp_bbr.c:1385:24: note: remove constant to silence this warning
>   1385 |         if (bbr->ecn_in_round && bbr_param(sk, ecn_factor)) {
>        |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 3 warnings generated.
> 
> The usage of bbr_param() with ecn_thresh and ecn_factor here does indeed look suspicious. In both cases, the bbr_param() macro gets evaluated to `static const u32` values, and those get &&'ed in the if statements. The consts are positive, so they do not have any impact in the conditional expressions. FWIW, the sk argument is dropped by the macro altogether, so I'm not sure what was the intention here.
> 
> Interestingly, unlike Clang, GCC stays silent.

This looks a lot like https://github.com/llvm/llvm-project/issues/75199

Judging by the number of related issues and PRs this seems to be a known problem,
and to me it looks like clang's complaint is "technically correct" while going
against "common in reality" usage.

Many projects seem to use -Wno-constant-logical-operand to work around this.

cheers
Holger

