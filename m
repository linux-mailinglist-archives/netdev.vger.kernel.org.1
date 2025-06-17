Return-Path: <netdev+bounces-198346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E25ADBDE5
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 02:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09BEC3A75F6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A880D632;
	Tue, 17 Jun 2025 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="vbSUyT46"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D101224D6
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750118561; cv=none; b=NMeDsOXL3ukpcQrft0KSoHBXahI+smtdUzsBGzr6K5fqPe7bkKfhuHnUWFPx4csGnj2fNV9eObpTyzQOQsn5rlWYmyjQDIJ+gUj2hLHO2qgFIajY3BQ/cHs61xjbqcOWB6AbbhjrUoyeUw9bDehhymATqnsUxdu56CW9vd3OnWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750118561; c=relaxed/simple;
	bh=qE5gS/cb5WJCX8/+6JNsf4hZQjjk6A7F4wDXfbywW18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVG7V8+FJzZ75AmKSA4Qw8Ssb66xEcgj09l7S0aPWN8LYlN15r8MCf+yxcavmAUo1XfVHK+vg1dK/31c43sR7cDQqqlXd7JpiXTj1zAjz+DoKd1DmafWzJIEzEKZ7qRgd8dD1/TZCJleYwO0jxIjkEAq8oPyVI3n5g002RP+S8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=vbSUyT46; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235ef62066eso77785555ad.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 17:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1750118559; x=1750723359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mci/E2KSU4I5xLqs0Cb0vS9PEv/c4ArqZ9Be8IBU+Gs=;
        b=vbSUyT46rwiiPg0+Ur4YEUlCgS3iMnExyRVZkhIAqExPprv0tpuubNkBu2JYhKhj/a
         QDgOijtw1dQbm0BEZ+92yG/txtq3RVg5i5JUtn/VplnQyKytesTOq6Y0j/RtJ3fBWK+q
         ssnzR+y+tQOkJNQknDch2pVMc6ZnFIEcCtf+qqKBAXOi6cBzHVZuFWOi0DjtUB867L3S
         d6vBpLv+L/NC4VzQuAki96+1OPb99dfTFHRxftSX66vvQ+uIWG/5Dlddfzdx6BUENjsf
         JAg//+rA6BiRUzmt7d94GNQvenC+JUbQfTa8nXelzZGVOcv0CqsRjX8f+WkLumBvCy5w
         CvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750118559; x=1750723359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mci/E2KSU4I5xLqs0Cb0vS9PEv/c4ArqZ9Be8IBU+Gs=;
        b=QUUOo2qjhbSn8BhGr/B8kyxRTsVLJ2oilbRQwtgNyfcDzuonGemZbrmeIzUWXW52bu
         S+/FRsvZMdplw+5ZNdCtzZRaPWX3zVgISoNwlME+VnRO16PxgXTWW/6l1FLT8Tbp90UP
         D5vr/Feg7edxVosgrtHLo7ZJKEg8yhCg+4v4j3JRwZ+RHRV9fhLBMeHYWwU7RBHBnCpE
         NCPgZ+0iUARJ2TKJLVGPDgCWgpERuNNTt2H0dw/gqWD3xQ206NX1uVAU6M1uwtbEemtb
         /x+q2+frT58o3FE9btUuShN6zpF/GU5OQ87d+nR5sW2PB2Ae+VAn/IXIeMWUdB6dpOrg
         tiGw==
X-Gm-Message-State: AOJu0YyJwkyMlODJlWK4kBhTBLBjb0bk0GUMojLeMf2zsVgbCIu520Gm
	+Q1ityRltlNn9CKrHv51pTsxuEvhAxVE/90bu4Aj4FDtPx0BVLfdqvfMda/U6pcxeVk=
X-Gm-Gg: ASbGncvOlwqa1Z8SwbiZoZTQYTakRFHtQK24sZ6PovFRsmj+xPWdX123q6umXbrCcmv
	0TxJwaSlV4yisds5THGUiiVAcH9Bh0E6CjitBDlWNJeTyi7oM8Y/RLf4aYZ4iJcBzxMiohublhT
	yrrom4T1zmgs1BlRtMGOVv5hY/QhRq/j9YsD8M9fr3fW7Lt+xyHvBGqHJHx6Np7SULD9q74z1RJ
	hoJfjY4bS47nTczZEr2Cc3zXwB2+57dgI27BOadr+yJWqTCtG+U7jw+thpmIUh0H5d/LhojrNrW
	dFXREz+vG1uuJv4xCaD/IjtApMOZKJ52JXXQmQsvSrDlo9G3ePnAGWos/+LOXCtEcB6LI0rdStB
	sY/rBtjXz3q/BPQZPhWFJn7vx
X-Google-Smtp-Source: AGHT+IH0yqXTbbR5YfV7E9WukTyorfeNvx62/feP0gcgUsFSSkkabQHjhOeKa6ehAbKpz4Xc91ZrHw==
X-Received: by 2002:a17:902:ecc1:b0:236:15b7:62e8 with SMTP id d9443c01a7336-2366b3de4e3mr165387105ad.25.1750118559354;
        Mon, 16 Jun 2025 17:02:39 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:14f8:5a41:7998:a806? ([2620:10d:c090:500::7:e85f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c216sm67412035ad.41.2025.06.16.17.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 17:02:39 -0700 (PDT)
Message-ID: <9684c5ec-3d52-44b6-89f6-e7ae606fe51b@davidwei.uk>
Date: Mon, 16 Jun 2025 17:02:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 3/4] selftests: net: add test for passive TFO
 socket NAPI ID
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
References: <20250616185456.2644238-1-dw@davidwei.uk>
 <20250616185456.2644238-4-dw@davidwei.uk>
 <20250616131310.61c99775@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250616131310.61c99775@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-16 13:13, Jakub Kicinski wrote:
> On Mon, 16 Jun 2025 11:54:55 -0700 David Wei wrote:
>> Add a test that checks that the NAPI ID of a passive TFO socket is valid
>> i.e. not zero.
> 
> Could you run shellcheck and make sure none of the warnings are legit?

The single shellcheck warning I get is this:

In tools/testing/selftests/net/tfo_passive.sh line 76:
if [ $? -ne 0 ]; then
      ^-- SC2320 (warning): This $? refers to echo/printf, not a previous command. Assign to variable to avoid it being overwritten.

I confirmed that if writing to the sysfs file returns an error e.g.
EINVAL then echo returns a non-zero status. The existing peer.sh and
busy_poll_test.sh does the same check.

