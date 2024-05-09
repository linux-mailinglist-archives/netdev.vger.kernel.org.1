Return-Path: <netdev+bounces-94842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542898C0D8B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C082C1F23F59
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228F914A609;
	Thu,  9 May 2024 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QN9gXcK0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F614A0BC
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715247396; cv=none; b=gafO/YALbfnYdfHm979hYolEXOPqOJR2fAs1GaQWR/g1RroFrE36z6fVP/hG06uW8KPu8dkFVR1kL/xVcpR4WYKKJZxgvvEmkxGPuzxkvQ5AQQU+I3L8aETyTeAwy1u0I5+RKcevwje7yH6PUvUr/XzdYVXsJnC5BVYVTJoNReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715247396; c=relaxed/simple;
	bh=7y4lG72F1ulE5cL/PuppIq5cgb5sd5W7ewRl0Wvabw8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KPIVzXbocsWSG5GJxSadQAO25fEbOJ0nIHSosOLxOZgc8HngwGfoJ92eEDfFnFD9CpGTKlcO+IH3lOWv6Jkv2sDuO77ldoubucJjRL71ec2JsOvHFwuWh/NuzV1MkThgmq8TGvsivtJxaur4WsbYUTDis6OPYl8BxBVHBasaWQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QN9gXcK0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715247392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PheUk3kEOpCxADT+X+vA1I8G4mnhuqeCI/CqTs3vZb0=;
	b=QN9gXcK0kNvkd0IPqwed55IjK4UPSsmOLycSjA5MwPykkRbOMu8wtR5MjI76C+h6nTCrnT
	SRIEqRqrSzaCcwj6tru85jHFHR0sDj9YGUJqRhYBqKA7cB5nFni4LG50YEbdDrGjwLHOmA
	gZ3BryKEZjByt0HnAqHNr1F/53wwCE4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-B9G92i-OP6uRI5Xb8Kj1Kg-1; Thu, 09 May 2024 05:36:30 -0400
X-MC-Unique: B9G92i-OP6uRI5Xb8Kj1Kg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34d74db6f1eso63737f8f.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 02:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715247389; x=1715852189;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PheUk3kEOpCxADT+X+vA1I8G4mnhuqeCI/CqTs3vZb0=;
        b=qkOMHXFryt0D/QSfX8DcyQvkv0FKHpifWjE1LnMbtPlWfVsVCcwxwdI+jI0VanvVDX
         BLO2/sirYg2CUKtUY0LJQkfCAnnUmwadTkj+8oj787dEg50JR6RZPrUOkv2UvrXa4tfc
         nSvl79uclhnli2430j1ju0Z4pYmqPzVkmtsTzFkcCctDqQhqV2N0InglRBwF/KLYPbjR
         4DoI2Ju9hZSxa4XWSTWSRRpRj7l0DJYEUVTUzG+ECSAX0pOmLvQxp4CujVlX/cSxw9ce
         IFQVub5CrpQVqMUi1yFhe+A1lafTeRHlwcVeJ12IokvmbMpKVnVzgffu7j8OF70LGf/Z
         NKQw==
X-Forwarded-Encrypted: i=1; AJvYcCVt/oKy5GTzcajiCGp19x69brIIzQ0oM0CDaiLNrYLEpcmPEQ/rE9Hh7Iq4KXntJPseBbLpLIw1MgN2eqzqv0PLpXsY/g29
X-Gm-Message-State: AOJu0YyADxPcnl574XIFesx3H4ZJ2BtyNAmuzAAB1EnTbW1aVGQSP/wS
	TQmtfislXOO1xvjLdADSDmHHZTcsa443povoNsYWtoN1/dje/ZjfuWEdIgY5kCcs3Ut0A9dv8h9
	CGGWR5UONuzx4Xq7wPaxLUL/mQFRYCOUWyQusi2XB6O6rJtD2H7+anA==
X-Received: by 2002:a05:600c:1c93:b0:41a:bb50:92bb with SMTP id 5b1f17b1804b1-41f7093ca92mr37655745e9.0.1715247389419;
        Thu, 09 May 2024 02:36:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY9TeFW4HNRF5vThUfxDUZA0Nq2e23KaqT7V/X6x9hGS8OvllR9VX6INevOp99PLOdM5YdhQ==
X-Received: by 2002:a05:600c:1c93:b0:41a:bb50:92bb with SMTP id 5b1f17b1804b1-41f7093ca92mr37655605e9.0.1715247389007;
        Thu, 09 May 2024 02:36:29 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b68:1b10:ff61:41fd:2ae4:da3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87c254bfsm53937545e9.17.2024.05.09.02.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 02:36:28 -0700 (PDT)
Message-ID: <d5016925e415c422c37f7ac1c5374a06bbdc2126.camel@redhat.com>
Subject: Re: [PATCH net] selftests: net: avoid waiting for server in amt.sh
 forever when it fails.
From: Paolo Abeni <pabeni@redhat.com>
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org,  linux-kselftest@vger.kernel.org
Date: Thu, 09 May 2024 11:36:27 +0200
In-Reply-To: <20240508040643.229383-1-ap420073@gmail.com>
References: <20240508040643.229383-1-ap420073@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-08 at 04:06 +0000, Taehee Yoo wrote:

> @@ -210,40 +217,52 @@ check_features()
> =20
>  test_ipv4_forward()
>  {
> -	RESULT4=3D$(ip netns exec "${LISTENER}" nc -w 1 -l -u 239.0.0.1 4000)
> +	echo "" > $RESULT
> +	bash -c "$(ip netns exec "${LISTENER}" \
> +		timeout 10s  > $RESULT)"
> +	RESULT4=3D$(< $RESULT)

if you instead do:

	RESULT4=3D$(timeout 10s ip netns exec \
		  "${LISTENER}" nc -w 1 -l -u 239.0.0.1 4000)

You can avoid the additional tmp file (RESULT)

>  	if [ "$RESULT4" =3D=3D "172.17.0.2" ]; then
>  		printf "TEST: %-60s  [ OK ]\n" "IPv4 amt multicast forwarding"
> -		exit 0
>  	else
>  		printf "TEST: %-60s  [FAIL]\n" "IPv4 amt multicast forwarding"
> -		exit 1
>  	fi
> +
>  }

[...]

> @@ -259,19 +278,17 @@ setup_iptables
>  setup_mcast_routing
>  test_remote_ip
>  test_ipv4_forward &
> -pid=3D$!
> -send_mcast4
> -wait $pid || err=3D$?
> -if [ $err -eq 1 ]; then
> -	ERR=3D1
> -fi
> +spid=3D$!
> +send_mcast4 &
> +cpid=3D$!
> +wait $spid

It looks like you don't capture anymore the return code from
test_ipv4_forward, why?

That will foul the test runner infra to think that this test is always
successful.

Paolo


