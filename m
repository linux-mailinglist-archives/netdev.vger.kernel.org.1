Return-Path: <netdev+bounces-122534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616EA961988
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1D6284FA1
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E36817A595;
	Tue, 27 Aug 2024 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGRYqQFi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1421F943
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795704; cv=none; b=qMIYq+7pOCgUOJvZIFErgDjeF7tAWv0UKzxNtqoQsDUgq8pc6tmjnjW9Rd6+Tym2AG7+PjfiDdLuiv+gClYe86v3sOFH838C+N3BNgCNN/OfYZUGgx2E33wDG/MlUnKevHETmxZkRWzDpwezyxkfgIJPlhF5vPa1XM8GojKN8Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795704; c=relaxed/simple;
	bh=F2MV7/X0q25dPDp3KttAOFKdhWgbDe6FOCR4ySHrSEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7JpQ7LO5tHa1m6nQP2uePVeVEKyZ1DsCM/GUS5wUV5Te4YLIkpLlmle5q1KFOdCCYohtM3w4brdRX28QeGcLHNlrfL3FjOSk5K5mgmmFojpDFEGeTVcYaVZBtkbDwL19qAYQjF8nZ1gN0mESOLbByYd+A20B4R4JznMRqlagwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGRYqQFi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724795701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2MV7/X0q25dPDp3KttAOFKdhWgbDe6FOCR4ySHrSEI=;
	b=VGRYqQFiAstAau6Oa2P1Omk7PQTWDqw1YgfZZt+Q4eO5KQXi7feWz7dLeAS10B5yBIpkN8
	iXUCRLHymi121OrFFwWiaX49GBTcHtn0MwSGiP9gRSpBpM+HXgb60TCCjwE1atZGlfrxBm
	tl4q0mZk+Q08AYVQJIlCQ39+MVh8Vq8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-5sm5STdNONKPyrazt-B52w-1; Tue, 27 Aug 2024 17:54:59 -0400
X-MC-Unique: 5sm5STdNONKPyrazt-B52w-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-44feeac4be2so88481791cf.2
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 14:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724795699; x=1725400499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2MV7/X0q25dPDp3KttAOFKdhWgbDe6FOCR4ySHrSEI=;
        b=WQomYXcL1POUZJ9pRUdBY3qZopj0ey4LMxr5mIlZU3Uwh3wE3yQtVS5cqD3xDK6j7S
         ItE5UK2tsx1R4ChPEUjSGmdBZrhUMxahRjVKGjUD/WAD16V2ENDhdyQMLRn5akBrrKkx
         qpYdTu3w1F5iDKM5WdPHLSHtdA+J3LT2H58Imh48d2r1nMSC982X1LiRbEW3Ff+hwIED
         Unl9cddQ7VxhrpEyLQjVjqCf6tddgFLBjuHybUoWVAFm2+xy7Vmr3QwvGxYe/e8R0fsw
         hlhazUsKnM0AbMVhng683sa+hHPmK5m6LgZLtsOxzRMFm7rnM7XNDf9EDD+89O9728tL
         SOeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZWNf4YVyWkBC7xVZ21jBo5BmsUWh66aZQS7SK29LTTdzIjj+apGekXRP3Bl9gzdG7p9FUetM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8oHR8U7EcQGpFgjGITviEgJ0AnUy9iY59IA4Xxcf9Ym7w6ec
	3m8sAqbUZ2w+NqV0e1TQAGov2ECDxCbISOJIyk61z+6y80tqc9kPbUbWJ/hrVCbuNgPNXeAfe58
	I2o/LbKVPOHkIN/Z9MaBW6WH/M0/d9En3bzCzQGoZptCZHUiLYH4BmIkTO9zo7cPlgf6VKLgVlV
	BLVIsI3k8aRmQTf7jKgWKGqIwPjQ75
X-Received: by 2002:a05:622a:244f:b0:453:56a9:3ef9 with SMTP id d75a77b69052e-4566e6721cemr1650771cf.45.1724795699355;
        Tue, 27 Aug 2024 14:54:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzis42HI8K2BsoPVv81L9lIV90uTyaQELolgxzOsc/l2qYTKEMHXv+V0JIhw/32riRqBXc8d1YYmDzB9j0Tdo=
X-Received: by 2002:a05:622a:244f:b0:453:56a9:3ef9 with SMTP id
 d75a77b69052e-4566e6721cemr1650601cf.45.1724795699076; Tue, 27 Aug 2024
 14:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZsMyI0UOn4o7OfBj@nanopsycho.orion> <47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>
 <Zsco7hs_XWTb3htS@nanopsycho.orion> <20240822074112.709f769e@kernel.org>
 <cc41bdf9-f7b6-4b5c-81ad-53230206aa57@redhat.com> <20240822155608.3034af6c@kernel.org>
 <Zsh3ecwUICabLyHV@nanopsycho.orion> <c7e0547b-a1e4-4e47-b7ec-010aa92fbc3a@redhat.com>
 <ZsiQSfTNr5G0MA58@nanopsycho.orion> <a15acdf5-a551-4fb2-9118-770c37b47be6@redhat.com>
 <ZsxLa0Ut7bWc0OmQ@nanopsycho.orion> <432f8531-cf4a-480c-84f7-61954c480e46@redhat.com>
 <20240827075406.34050de2@kernel.org> <CAF6piCL1CyLLVSG_jM2_EWH2ESGbNX4hHv35PjQvQh5cB19BnA@mail.gmail.com>
 <20240827140351.4e0c5445@kernel.org>
In-Reply-To: <20240827140351.4e0c5445@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 27 Aug 2024 23:54:48 +0200
Message-ID: <CAF6piC+O==5JgenRHSAGGAN0BQ-PsQyRtsObyk2xcfvhi9qEGA@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	Madhu Chittim <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 11:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> Literally the only change I would have expected based on this branch of
> the conversation is slight adjustment to the parameters to ops. Nothing
> else. No netlink changes. Only core change would be to wrap the ops.

FTR, the above is quite the opposite of my understanding of the whole
conversation so far. If the whole delta under discussion is just that,
we could make such a change at any given time (and I would strongly
support the idea to make it only when the devlink bits will be ready)
and its presence (or absence) will not block the net_device/devlink
shaper callback consolidation in any way.

I thought Jiri intended the whole core bits to be adapted to handle
'binding' instead of net_device, to allow a more seamless plug of
devlink.
@Jiri: did I misread your words?

Thanks,

Paolo


