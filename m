Return-Path: <netdev+bounces-192011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32424ABE384
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 21:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84BD179433
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 19:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303A525E80B;
	Tue, 20 May 2025 19:20:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18235893
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768809; cv=none; b=SvvlR/0iS/P6an93PhXRRWBTiihH3TL5nDw4Rkj0TBnbU7l5BFgP/rN/BmIICWv8iV2GP/yXCV0QggmJPyudyC2B6fIjieuuKLLEFXCMN4z5HuPnqWKRHZjgUYbG2gFOBjYrnhbd095NSc5l9atsZ7K70idzhpZG3RKqInX0CjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768809; c=relaxed/simple;
	bh=ol1SAIuHF06LdjXN1BdF9dC58+uff1vl5yd3KBx2Ahk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdManaZBH3ja6DO7zvBqHIC2tlKVxmNUbwRfxCKDPq5YYXkxqikL+xYIc04rqURseqwm5ah1HjLBJ2tYqaspHy3CMjVb4CbV0BZCMz+B6/diGomULh2RxjD4DyZvgELziRgGHpiqI9klZXjNfIB1MHMOZk4Epmjpd0NhzoBNuGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af4e0.dynamic.kabel-deutschland.de [95.90.244.224])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D5CBC601EEA49;
	Tue, 20 May 2025 21:10:54 +0200 (CEST)
Message-ID: <7d901760-460b-491e-986a-4c5a4ac1fe17@molgen.mpg.de>
Date: Tue, 20 May 2025 21:10:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] net: ice: Perform accurate aRFS flow
 match
To: Krishna Kumar <krikku@gmail.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
 davem@davemloft.net, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 pabeni@redhat.com, sridhar.samudrala@intel.com, krishna.ku@flipkart.com
References: <20250520050205.2778391-1-krikku@gmail.com>
 <4068bd0c-d613-483f-8975-9cde1c6074d6@intel.com>
 <CACLgkEb+5OU+op+FvrrqiA1mgsp7NbA=KB_dCa532R6AL2c3Kw@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CACLgkEb+5OU+op+FvrrqiA1mgsp7NbA=KB_dCa532R6AL2c3Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Dear Krishna,


Thank you for your patch.

Am 20.05.25 um 17:44 schrieb Krishna Kumar:
> On Tue, May 20, 2025 at 8:18 PM Ahmed Zaki <ahmed.zaki@intel.com> wrote:
> 
>> Are these numbers with the patch applied? Can we get a w/o and with patch?
> 
> The numbers are for the original driver vs the new driver. For 
> purposes of calculating them, I had sysctls in the code (removed for
> submission) in the original and the new driver at each of the
> locations given above (a simple atomic64_inc(&kk_arfs_add), etc).
> 
>> A table might be better to visualize, also may be drop the
>> "rps_flow_cnt=1024*" case. I think it is enough to show min and max ones.
> 
> I will re-send the patch after adding this table (and Simon's feedback).
> 
>> Also, please add instructions on how to get these values, so that
>> validation team may be able to replicate.
> 
> I have a large set of scripts that measure each of these parameters.
> If you wish, I can send you the set of scripts separately.
It’d be great if you could share the scripts with instructions. Maybe 
you could even publish them in a git archive.


Kind regards,

Paul

