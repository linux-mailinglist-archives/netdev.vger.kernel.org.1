Return-Path: <netdev+bounces-213420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA568B24E9E
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8540D2A177D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE02283CBF;
	Wed, 13 Aug 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6ojs13x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ED1283695;
	Wed, 13 Aug 2025 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100367; cv=none; b=Ka8cdrYwWb+faeen1TM2PypApxNGF2K/1uuSMaTtDtKEwW9kirwntEe7+PJaQypELueO6CBIgOQ6oNU35Na4M30r5+Q3xuTa4N8Z3L/Efpj5Qlwsr3S0TQprbq22iX+DxKU5/0r2s+1oBW/do4gpH2HXZItfLzFckpegEOMtcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100367; c=relaxed/simple;
	bh=jLrG9NFu8MJFiUhadKO7/4epzaxXsjOiT1guXEIqKPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTBoFp9F8/QBfuIiXm/l+w0O4RAV3TUv2F1ypS59ZMb7klUGt2Pj5xmmoNrmPlDkuH9qkxuwa+L2Drt/m+okPfMwAF4KEyd+I9UBOsb7rlssxn+w8cvLqG71nWQwklpCka5kxYDwHbe70S5Yqon265iqa109ck5vM0QTtXw0dBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6ojs13x; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b780bdda21so5437925f8f.3;
        Wed, 13 Aug 2025 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100365; x=1755705165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+znz0ctiOasncET/EGbUXWM9UOUtXGC/Jr9mwZm5IA=;
        b=h6ojs13xvULoRIu9g8t71pvu+lNdre/704CIjXMDYkbyE5koXdyIvsdgg2av7oEvlZ
         POCkZp42o24YEOr2Nm8rpA/gNchwM0lV6DuiO/3WqkNsAT6oXYKWFdUZylfRhXAgJcB5
         VruohFTKsAWn7XE3u7fCxPK7Q9LHCokR2DYB2NifUREhMtkgi46a8qj+h6SeZgQp3H8S
         jvVGoUh1gCeD3E5GnWw/N6U90oPS6MFvqT9Kqik5o9BEaettPL1KW3GN/UKGuJoIlsdD
         /dnKKJ6v91b+wSG7deZUQC+JrqGr559inY9Ze/X8jyqI6KJJWXCVS/7AHZXr0RQAmDi2
         SaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100365; x=1755705165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H+znz0ctiOasncET/EGbUXWM9UOUtXGC/Jr9mwZm5IA=;
        b=DzAObSIvY0gaAJ5p0yZUg2/5QIHbuo8fLw14kFj2OweCsyoy9nbhWmX4rzF892sj0c
         PlpQww0ggLeGXyZt+kMC1hGmAcVHwPlLYIcbAtDMtobITWeW8to4V2/q47ehMaNimb+H
         qm4fS79QMYMfjsoACwhkX9LvEyBejQJoSSjqbLEvvA7x4CzFDrQwfc9rguUiw4AXzFFs
         l+uXfaVXD8rk9qu/GQL8Yyn7exV7EG1tyOLR9n/Ex+JfB7LAnBQJkpD0XDVvjUcTR/8y
         nRw2YW+ln7nxB46K6dJPu4JDoHKluZpVceiIrEn8iVYC78nUn37h/LiHOQMAUuygQsiY
         ndDA==
X-Forwarded-Encrypted: i=1; AJvYcCUZMaT8K9T2wqPPdkD3dUEIQXVIgFp0EnO7FIwTHxgR0oKuZX3Zg0nTSYzACsVq+DupPZ4WvnMBmQ43tqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj1xY3ooio6YHwzoQFG1cc2fXUrFBzRHAahJ+impuXJ8gwFXCw
	DTedHf5B1Ed97j/azk1TffPISeGdj+Qmy/xEk2/75CX0gtN5+TMCLeZR
X-Gm-Gg: ASbGncsMr3nmvPF9Qu0AciEM63Ap41LlUw7ymYVyPi4y4tbIKFOHYNsloEaq3l1bcVW
	pUSUO+ZpyJ8rPWKTVMvJKZ8aZK7suV1J0xx38yL19AFBUETu0z3PppXM858OXGRFEBCMLdbTUT7
	AQYmMrR9+/iHp2y5gx4xyv8RMo633XnjGejjKJKuGD7gpF8BnzXOWyvsp0zDeInJL+AqQG90ghD
	+YnD2+vZRXC2rdr/KFU1xeC7Fc4MAYSeS7A2hphQnAdF4uiqiBG2ljeNrvyNTpQVgkFj0V8r8X8
	DLXOIZb0d1cFqZ57Sq7V83kXIYn8ceMZgubCj058XzSU6rOIFCIfSmn2YVlH0V7YJ4mSq2GuGHd
	lyglYt0FBqGLUNeYc/M1v3MofXgbDsFgM3Xlxi8PqwQN+
X-Google-Smtp-Source: AGHT+IHGIudxG6apk72hPUJRiLUkWf5929Yd0MAMSWD/3MFXV9sjNvWpJ/iTw4DRQwemL5DM+hARaw==
X-Received: by 2002:a05:6000:2c0a:b0:3b7:83c0:a9e0 with SMTP id ffacd0b85a97d-3b917e40354mr3012609f8f.25.1755100364496;
        Wed, 13 Aug 2025 08:52:44 -0700 (PDT)
Received: from localhost ([45.10.155.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b911469bffsm6978390f8f.36.2025.08.13.08.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:52:44 -0700 (PDT)
Message-ID: <79066634-1584-4968-ba76-81075b8cc639@gmail.com>
Date: Wed, 13 Aug 2025 17:52:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 5/5] selftests/net: add vxlan localbind
 selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com,
 andrew+netdev@lunn.ch, dsahern@kernel.org, shuah@kernel.org,
 daniel@iogearbox.net, jacob.e.keller@intel.com, razor@blackwall.org,
 idosch@nvidia.com, petrm@nvidia.com, menglong8.dong@gmail.com,
 martin.lau@kernel.org, linux-kernel@vger.kernel.org
References: <20250812125155.3808-1-richardbgobert@gmail.com>
 <20250812125155.3808-6-richardbgobert@gmail.com>
 <20250813073451.159c5904@kernel.org>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <20250813073451.159c5904@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Tue, 12 Aug 2025 14:51:55 +0200 Richard Gobert wrote:
>> +ip link help vxlan 2>&1 | grep -q "localbind"
>> +if [ $? -ne 0 ]; then
>> +	echo "SKIP: iproute2 ip too old, missing VXLAN localbind support"
>> +	exit $ksft_skip
>> +fi
> 
> Could you add a link to a public GH with the iproute2 patches,
> or co-post them?
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#co-posting-changes-to-user-space-components

Will do.

