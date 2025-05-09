Return-Path: <netdev+bounces-189161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CFDAB0E3D
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0AF1C2402E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 09:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64CB274666;
	Fri,  9 May 2025 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRQVoxtt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B9414F98
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781677; cv=none; b=NfKwcSlFTMwMeJszCHfUY9xpz8XQPRBsGany5HWc+AdwkQW8EAG10AqTrmVJ4ovCAvN3Rb/7itu4gWLl26qygDnQmgbf/moqtL7C/pUCbUB3n+IPNrfI5/6SrGh5G91DogePRAvZVprT6eumQ5PGipcX0mDU3X/vePaws6ASRgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781677; c=relaxed/simple;
	bh=LaiRVlY1XHmjXGkSB42RZ58wAxMxcG5NilT7qAmy+SY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=RfpLRJkJCv1CLQbRaT9KbkXvhSNNhfAZPG3W7mAMp+YOrNMpRZlrkd1Dbblua1XY27mwA8F8Cki/92HMElRadjFfdhWhRb/0rKVYx7TMmp57Xym/Ofp9ZVJn2uufXlmnEEIwA983lT/saicZwCb9fZrw7Qe4WevJ0a46MvWzT3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRQVoxtt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a064a3e143so1027634f8f.3
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 02:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746781674; x=1747386474; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tk8w2X7y8Z5lKM8ntqt0qThCCFclC8tSHB/yXZTWzsI=;
        b=DRQVoxtt6KeetKSwae0fHIGKWlyXHnO2t/5pb9TYzeBku5JjegnuvR1KEyiLKJzVQd
         r9eBBM/9zJgJG7IxP5DfKQZmJfFVGh9To0cfXISV08boQUsrxjIQcVUWgVSSX0JohHMs
         JZg9Y5pYaK2+EiUbkMCi6LvbCxLoRqLchTaBy2um78mgEKKpX9zVUOmGjqtjRBI4qzyI
         ha1+k0kdtt7Z4gBZQTgHQ+nEbN8J2DZSrIqttlSKpSrjoibPWUL8OPxQoHWhCNT9jaxp
         vBmAlih/UPt4nT3ps0qLbgg08Dl7Md4VSXzFK3asnay77iV9vbpoqK0gYHtPGF53jLXG
         MSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746781674; x=1747386474;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tk8w2X7y8Z5lKM8ntqt0qThCCFclC8tSHB/yXZTWzsI=;
        b=qfyAbCumLx1shbot9oAKJ7Bm9M6zUg8HhUeDwQpNvDMbMsuakSNiTGgcBasFRSTZEi
         2/tLYceectUHwNAeltA/UIcaF597KIwrQgg1zInhCm82Tk1g/hwydAZZjt3pD4ux1Aqc
         a0iuoYuyOOVPnpPI4zV3SNvdbH9I1JxAZcZKFpteJZXq3kda7cWZfyY9tjJbQr2lsWzH
         dvSvn2wFVc9y2e0I+AXGOiUtlAOx2KBR2HXx54/y2yKKIFGl3hbuLp+bC1cCGmhq3XlQ
         6lnaSGGunGPvLKlD+AxHgr2H9nFLmGrbB/XXw22T01lymI4BixXvRSnHL/KwlelLIs8p
         98Ig==
X-Forwarded-Encrypted: i=1; AJvYcCX1DDdrDk+jJn7BqpUM8JPZy1sbXfEZuEbHWuJg3WDJHoA9YShjTI+r9XWRexOIn8XCfxmVFeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFmITE46GSafcwXxFoV48vmUR84BLKIkS666KqjCvzSXPbQTr/
	VAwSi0bXtF9zyLJycyapVWjcjdUHV+sMUOckkqHq6UBZdJoACMn1
X-Gm-Gg: ASbGncuGyKcdGoalT9MmEsmq2TGsRGT4G8bNTakYZG+AxoL6pLpuWcMm7pz6xcCiyTL
	hT51isIOnmsLdjYfbtPMFFAKdKqenAYRLkLt9B0JUg5fPbR6nhJmPQe1KNHhI0jfajLKQsGhWdI
	RyAoXjQtiJ5VjqGUCPQFv9kP/RQ5dvUfy84sGaieDhzIH3z2i+8nrGwNzjCG2C2hpkSqrC5vjQM
	blBBle6PADu448E9d9EeKRBlYDQzuUatil7hPOIFb/tvw06RnE6FGFyCSxQhE7OEXmPJdQQ32Sx
	krQ5QVBtvtUF3xedJ7/g3VFR/sqPvNILMTTvksULKHuXc4V1U9rurNLi6q2DISAf
X-Google-Smtp-Source: AGHT+IHpjpMGnQzttbRz+BAIimA42Iuz3ROxXmVc2VxGngo+3gXFwFqifSRsS9RuySgrOQFWv3mmAg==
X-Received: by 2002:a05:6000:2207:b0:3a0:9f24:774d with SMTP id ffacd0b85a97d-3a1f6487821mr2160273f8f.45.1746781674115;
        Fri, 09 May 2025 02:07:54 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:dcb9:386d:2500:439d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2cf2bsm2564370f8f.80.2025.05.09.02.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:07:53 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 1/3] tools: ynl-gen: support sub-type for
 binary attributes
In-Reply-To: <20250508095439.26c63ff3@kernel.org> (Jakub Kicinski's message of
	"Thu, 8 May 2025 09:54:39 -0700")
Date: Fri, 09 May 2025 10:05:18 +0100
Message-ID: <m2msbmm9wx.fsf@gmail.com>
References: <20250508022839.1256059-1-kuba@kernel.org>
	<20250508022839.1256059-2-kuba@kernel.org>
	<CAD4GDZzR7DV-z7HA7=r9tmXmgkQu30K5QE9nAdz2eZfvKPOusA@mail.gmail.com>
	<20250508095439.26c63ff3@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 8 May 2025 12:33:10 +0100 Donald Hunter wrote:
>> >  class TypeBinary(Type):
>> >      def arg_member(self, ri):
>> > +        if self.get('sub-type') and self.get('sub-type') in scalars:  
>> 
>> This check is repeated a lot, so maybe it would benefit from a
>> _has_scalar_sub_type() helper?
>
> I've gotten used to repeating the conditions in TypeArrayNest 
> and TypeMultiAttr...
>
> Looking at it now, since I'm using .get() the part of the condition 
> is unnecessary. How about just:
>
> 	if self.get('sub-type') in scalars:
>
> ? None is not a scalar after all

That's definitely an improvement.

I realise that it's not so much the repeated conditions that concerns me
as the need to check in so many places. Perhaps there is a refactoring
that specialises TypeBinary?

