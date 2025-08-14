Return-Path: <netdev+bounces-213780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B44B2691D
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4199D5E7654
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156F9321439;
	Thu, 14 Aug 2025 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdjeUoZG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECA41A9FB8
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180766; cv=none; b=jXx4GydHt/xK0Abx8xNa9GvBB0ap09/soz0DETuj4akacqO2MVD4jvG0jOBAVxTdTxwsvOouID+ZAuNBy3pkXG5goYmCuj9ZatbHPsNHqd58PyC94Bqy65VBOmunA17eYt8XaeyfzqbpxXpxdbkkv8KltsTbpwK/juNGUAPTJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180766; c=relaxed/simple;
	bh=ceEBZnW9v0atZSp81NwPUVa+Pi9uVYQtPlczHW7MT8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HauO+j0SfyglrxYs5zXadF1wiufuWLS83pWZB6gnxDGwTlaWNxzxwJCfn3rkqpFi97z5jhqnDbQj3uqan/POIcvXuix+yKbvxMe0aLFiD1Keg8UbDeSk4b5TwH9XZodC0sJK/rnGGAJp9RhVu3MUQS3Pdos2r+jNGCphJNTA1KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdjeUoZG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755180763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2KtJdAWLx6hy9kqYg47C18thcTvmZH8fFDU3nS8jdFs=;
	b=cdjeUoZGaPBUZBGH/+vWTCqkNXuyimEy6PDCSZgKqmOESZ4nFKePOp7EDjCMUe6IT6zy3v
	wEZ87lJHd7fvTO0D02wiveGEc0VZasO6E7q1DOAnte1pLtz/LTGApa/04Os6KCBFkQ1BYK
	NlkTs9Ayb+h1OiJ5Bds/0fb+YJhnlBQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-ciSm_NSOOAe-IZwp6Md3Ig-1; Thu, 14 Aug 2025 10:12:42 -0400
X-MC-Unique: ciSm_NSOOAe-IZwp6Md3Ig-1
X-Mimecast-MFC-AGG-ID: ciSm_NSOOAe-IZwp6Md3Ig_1755180760
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0b6466so5837675e9.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 07:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180760; x=1755785560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KtJdAWLx6hy9kqYg47C18thcTvmZH8fFDU3nS8jdFs=;
        b=vy6NvuanitqKSATtpPIoAhLm/F4PVvBxvBGGg3sW3IiMAmXFz5R9FDRa3p8e22WdH+
         IYm9GU9nw9LQqhISo1f5O9U9TaOwN4V/213GweJtuSziqd55BvF2h4ycn587mvDeH5T3
         32312qYuxfEPhlz2U6e9dzqHZUYYlbyIPArtOvb0VpB/6LkIiWtrH/54Zm5Dpl2YPKuh
         /BKGFwP8W7O2l9iZJNqY5shx+961PHFGTNeFpidZkJ4b8GDPx61aMLTjVe1aey4JT/jN
         VLCmeJti/ErpcrYPEZUj6PhOSJqj7BxO4OYVqgbSeP+OMFF9JKbOCJJ0FdxytKDpo9Eq
         MFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK57r7C5OJlaJwMgXdHVV2Wlo23zEa/B9QKhINhOLMbYsRgLdWQn4/M/59MpLA9XKSHonjsQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmFJdEK/OD4JJhwzMEOGfQYQ5RX69fr1kOhpHhrDxKUOh5jtN
	ytLEk1tqTAgqJU1i5wY8sNIORWaEAJwVfh/HWAZqQOB+JX1pF/lUVsR8/ga4T+aVYXvaqF3SpmY
	HvQrMKKxmAWRukDprDwhkBRwZGUjG0WCZQIKUJA89aQDcXYIx4HA+t3tT7A==
X-Gm-Gg: ASbGncs3HsMAk5DyR48NIh3oxkq7dXtQe7igA6dsNK0A9hzpc0p35z0bPWRdE+l5CNI
	w+OtvBeu13NqpOr46Zvka+jTEHZv7YmcZtzOy8KebGKiin0ZtNLzftR19SVgWfXCtxfKsfbx8QP
	qqcXgR2AdmE0vDTm4HyqJ40/aPaTrhaV+AkL/2Brn3WyPyahQlSkNMEiooLcTzYnEDKzdybutpS
	YQJoigtC+D+RjOHEky2rCecWxUIIOKy+ejGf+07oPmXs07TnFHucomSAYVnizSPiZX5jDMacMXN
	mShXRw8iCUuUhBW/dp39kIIVNIf9Wc5oIzMjZaxUyyErT6uWhk+HblnaE7VY1aMGpMh855aAt78
	w9oPMgoK+rzc=
X-Received: by 2002:a05:600c:1f13:b0:453:81a:2f3f with SMTP id 5b1f17b1804b1-45a1b6833femr32645585e9.30.1755180759956;
        Thu, 14 Aug 2025 07:12:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLruXeCJ+/TQeE73UnQkHzOeDp8l/SNjAEjqEa6zlOGtsa6aIjvYUV6M2vPcjET49/BTRm4Q==
X-Received: by 2002:a05:600c:1f13:b0:453:81a:2f3f with SMTP id 5b1f17b1804b1-45a1b6833femr32644955e9.30.1755180759499;
        Thu, 14 Aug 2025 07:12:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b899338sm12760405e9.7.2025.08.14.07.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:12:39 -0700 (PDT)
Message-ID: <3966bc2d-307f-47b8-9f8c-f31a33f1f84a@redhat.com>
Date: Thu, 14 Aug 2025 16:12:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 11/19] net/mlx5e: Support PSP offload
 functionality
To: Daniel Zahka <daniel.zahka@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
 <20250812003009.2455540-12-daniel.zahka@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250812003009.2455540-12-daniel.zahka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 2:29 AM, Daniel Zahka wrote:
> +struct mlx5_ifc_psp_gen_spi_out_bits {
> +	u8         status[0x8];
> +	u8         reserved_at_8[0x18];
> +
> +	u8         syndrome[0x20];
> +
> +	u8         reserved_at_40[0x10];
> +	u8         num_of_spi[0x10];
> +
> +	u8         reserved_at_60[0x20];
> +
> +	struct mlx5_ifc_key_spi_bits key_spi[0];

Minor nit: checkpatch suggests flex_array usage here.

/P


