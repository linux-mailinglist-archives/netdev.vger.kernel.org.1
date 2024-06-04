Return-Path: <netdev+bounces-100450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 716C08FAAEB
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 08:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE391F21713
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 06:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65C413666D;
	Tue,  4 Jun 2024 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SwPsTkSD"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53630801
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 06:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482923; cv=none; b=hNXmClPlhppalFoy476zZaW75uPKtNG+GsOJ1xLiCBGZwGao8E5w+EriOENqBP0EDrDYIxG8SxPVGjFKO+mTeJ5+gO/Zp37loxo8/xIroBbjMhC1ytwB95bu5EiAHuDuwjxCHCzA5vHm5sE0vQlrZQfatmU0qsVXIzfOD6Om9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482923; c=relaxed/simple;
	bh=s6e1CzX/te9TI0/J+khQeFzmjwrbnRAEJBA9jiNlg+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeiRb+/o3i4z7akgn1vHqckbvZE7ctwKYrsDuSwLNCiiLvtZwO9O+fbpJck868U/EKDKYb2QA03mYez+Pld60NFKxYcSPlJebhkLiXAVdIkFJE7xOIVMmcZK3w/nr4S97CLplmZamxVnHk8tMmZlBdlSHm7Xpr0aZAj311nDTeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SwPsTkSD; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=lfbTDsruJVMCcvqGaNqkhWmW6/jTVFZovlQJPpQpEp0=;
	b=SwPsTkSDDG28Wkhbd9iZUEYxx8IPHslkCXYjhQMGxgM5VPUjLXydumiSxMIG0X
	jS+uuSJ0jcnCW8OfY2VzZNqJvF4YX3/aIy6RHWEUkOi/qk6NtYAqGmFVa5Ag+Dks
	22kfZXixOqv8maTDL/4E4PTRV88xc/C1UeH741g7L4hR8=
Received: from [172.22.5.12] (unknown [27.148.194.72])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wD3n51vtV5mWA0EBw--.5030S2;
	Tue, 04 Jun 2024 14:34:24 +0800 (CST)
Message-ID: <4545d7af-3cea-4411-83ee-c6eb5696b15f@163.com>
Date: Tue, 4 Jun 2024 14:34:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] seg6: fix parameter passing when calling
 NF_HOOK() in End.DX4 and End.DX6 behaviors
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev <netdev@vger.kernel.org>, contact@proelbtn.com,
 David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <2a78f16a-0ff5-46bf-983b-9ab038f5a5cd@163.com>
 <Zl4YGQ3pqEobNTAl@calendula>
From: Jianguo Wu <wujianguo106@163.com>
In-Reply-To: <Zl4YGQ3pqEobNTAl@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3n51vtV5mWA0EBw--.5030S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUnpnQDUUUU
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiJxXzkGXAmGNg+gAAsV

Hi, Pablo

On 2024/6/4 3:23, Pablo Neira Ayuso wrote:
> Hi,
> 
> On Thu, May 30, 2024 at 03:43:38PM +0800, Jianguo Wu wrote:
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> input_action_end_dx4() and input_action_end_dx6() call NF_HOOK() for PREROUTING hook,
>> for PREROUTING hook, we should passing a valid indev, and a NULL outdev to NF_HOOK(),
>> otherwise may trigger a NULL pointer dereference, as below:
> 
> Could you also add a selftest to improve coverage of this infrastructure?
> 

Sure, I will add a selftest to cover this case.

> Thanks.


