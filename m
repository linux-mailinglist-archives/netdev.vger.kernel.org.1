Return-Path: <netdev+bounces-53399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5C7802D96
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5115B20943
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 08:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B597FBE4;
	Mon,  4 Dec 2023 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="0IDV24f2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAF185
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 00:52:20 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bf26b677dso874438e87.2
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 00:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701679938; x=1702284738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0hnHEeYG3nS6v6F/DxWFEbRM3Z+Kp9WnIOWyribGJY=;
        b=0IDV24f2s3qu8XUmctBo6XkWLd5Eloi9YBP029su2E2ouVqD4FFI2CNmsIR1K25UZX
         4C9P3K0HiIk+YKb/tNRn6UjNHzFDCf3Hgx17tsHHNyHZLzYXoxAvWbXAmDYvyn6cnxjE
         oav/5wzB7kqHqKGTIseeVy5mVBGayWJ5O2+qwxr+UENbcsLdoyHbric3lG5d0jzAZOVZ
         Uq3lhqEzNaWwDellMPvXSEFByofgBTkdWTg/kiaRiGaGVQbjqKrw4rV+4qamdRtxZ8gn
         YUZRanyUuJ2bMg/y4R9Wr21jV9LecFHOdm1frUqEtTBdqaHXxbBFtzFkRX//cRnW4DbO
         3A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701679938; x=1702284738;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0hnHEeYG3nS6v6F/DxWFEbRM3Z+Kp9WnIOWyribGJY=;
        b=HAjQy4CPe/VwZtyUNvbCTvk3ySwnINt3lDei+/DdLy7TXJxLp1h5865hc9puIVDMXV
         oDVZ6k7NLbS7dfocrUMlXKwDFPHi6VVEg+ShrkswKz3ONIOvSU3nE7VZ90bQSU5uijxN
         RKa2yWD1gH4YUhTYPbigC/LNIi6s9RJdWNhsrr3iNG0Nr1G3/U16exBRAJNZNIO88+6U
         N/Jb3Tsc9FGhci5GB3dMNCGqSRx3L/BC2k1sQ+U5Pj3z7LK4s7PiqiLQjTf8hRM3yY3N
         cq8EPBmgCDfqE3OPkbdvkydAeL/PiUM6Izp9TxYGUVXWwK9OxfRo7VK6spBn+TF0eOab
         vegg==
X-Gm-Message-State: AOJu0YxHxpFN4PpAmYxpZF31xQ6An6QZoV9/VXZTs/DOaTptN6iDxUHg
	NjIpE8cvRT4EY5IxYl+5Gxtw95WfuJN9hE8MJwM=
X-Google-Smtp-Source: AGHT+IH/90r4DEeXfOfhkrLdxjnzsegXFAOyQZ0LYKpQwEXbQzNRcXkHmKZq1hFf7gIesXJx6xz5aA==
X-Received: by 2002:ac2:5a4d:0:b0:50b:f69f:b428 with SMTP id r13-20020ac25a4d000000b0050bf69fb428mr325410lfn.27.1701679937505;
        Mon, 04 Dec 2023 00:52:17 -0800 (PST)
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id m16-20020a056512015000b0050bfe37d28asm22833lfo.34.2023.12.04.00.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 00:52:16 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: mvmdio: Avoid excessive sleeps in
 polled mode
In-Reply-To: <20231202124508.3ac34fcf@kernel.org>
References: <20231201173545.1215940-1-tobias@waldekranz.com>
 <20231201173545.1215940-3-tobias@waldekranz.com>
 <20231202124508.3ac34fcf@kernel.org>
Date: Mon, 04 Dec 2023 09:52:15 +0100
Message-ID: <87a5qq9wow.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On l=C3=B6r, dec 02, 2023 at 12:45, Jakub Kicinski <kuba@kernel.org> wrote:
> On Fri,  1 Dec 2023 18:35:44 +0100 Tobias Waldekranz wrote:
>> @@ -94,23 +88,24 @@ static int orion_mdio_wait_ready(const struct orion_=
mdio_ops *ops,
>>  				 struct mii_bus *bus)
>>  {
>>  	struct orion_mdio_dev *dev =3D bus->priv;
>> -	unsigned long timeout =3D usecs_to_jiffies(MVMDIO_SMI_TIMEOUT);
>> -	unsigned long end =3D jiffies + timeout;
>> -	int timedout =3D 0;
>> +	unsigned long end, timeout;
>> +	int done, timedout;
>>=20=20
>> -	while (1) {
>> -	        if (ops->is_done(dev))
>> +	if (dev->err_interrupt <=3D 0) {
>> +		if (!read_poll_timeout_atomic(ops->is_done, done, done, 2,
>> +					      MVMDIO_SMI_TIMEOUT, false, dev))
>>  			return 0;
>> -	        else if (timedout)
>> -			break;
>> -
>> -	        if (dev->err_interrupt <=3D 0) {
>> -			usleep_range(ops->poll_interval_min,
>> -				     ops->poll_interval_max);
>> +	} else {
>> +		timeout =3D usecs_to_jiffies(MVMDIO_SMI_TIMEOUT);
>> +		end =3D jiffies + timeout;
>> +		timedout =3D 0;
>> +
>> +		while (1) {
>> +			if (ops->is_done(dev))
>> +				return 0;
>> +			else if (timedout)
>> +				break;
>>=20=20
>> -			if (time_is_before_jiffies(end))
>> -				++timedout;
>> -	        } else {
>>  			/* wait_event_timeout does not guarantee a delay of at
>>  			 * least one whole jiffie, so timeout must be no less
>>  			 * than two.
>
> drivers/net/ethernet/marvell/mvmdio.c:91:16: warning: variable 'end' set =
but not used [-Wunused-but-set-variable]
>    91 |         unsigned long end, timeout;
>       |                       ^

Rookie mistake, sorry about that.

Looking at it again, I think I was too scared of touching the original
interrupt path, as I have no means of testing it (no hardware). I will
try to simplify this in v2, and hope that someone else can test it.

