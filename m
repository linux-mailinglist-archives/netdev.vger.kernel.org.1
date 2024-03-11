Return-Path: <netdev+bounces-79071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A14C877BD7
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 09:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2F21C20A8D
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 08:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FA511C83;
	Mon, 11 Mar 2024 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uH1d+IRc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D269134C9
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710146594; cv=none; b=hD38nZJDF4mtkoRhMe3WnibLcq+8g2PftPP/uJm8Q0jEFsi05B5qLHg7YcVFNtbpdRfL4QP7Ii2RnsbCLd6bskgFpw8fcC5q1wW3XR0mHfggbvCTqVTH7aldn2i35LlhqYNoFZ3dkzhppjPjZHLgGzwgO3zn1wdDNdmikxqzQYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710146594; c=relaxed/simple;
	bh=nOB2jyxF6g+e/URwBHkUyRxfgyL/8+J6SjdGNs1lV6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxiTFr+MknJq1qCudTJqSgdc6g4ymEUGkpV9VDOvHzWbn0qRNNzrr7XKTxBsH2rayyH82aeRWlW9a+ZxFlOjPsEmT8HbuysUMsU0vNOYzEr2UienM+ooC9LHHnVR9CTsQF3AOxmF1fdIE184DL4jrRYn4LZfFpfW2u/lPKBD048=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uH1d+IRc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e1d327595so1539000f8f.2
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 01:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710146591; x=1710751391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nOB2jyxF6g+e/URwBHkUyRxfgyL/8+J6SjdGNs1lV6k=;
        b=uH1d+IRcNPF94M9Murvo7In2gkVgQgaP1N9xqI2MjVfcpidTB+m7LAHAXdEmNDUEim
         bJvLPW1qLAkzVprX5CQvpohZK1u5K5ax8+7H4OVZ6rwOQau4+5BEXGSZfr7zim/w5d6S
         vj4sM63sxrcAwF2EJZhU/0g4CaVqGdn781NMo81LciqFg/wpVJiGBmvzUIxdJzad1vzh
         XkE6BPaF14YeUa9w5ORb2hK+X+c+/7FGW32vro98DRmmuo9DX3yB30w50dcZRjE++i2i
         YSvktpDDlhY6FAQu0cjfGaCKa71yWtwfcWCdMfiQ5daQ+pn8kYC09eB5QQBCi/D8Sco5
         /faQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710146591; x=1710751391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOB2jyxF6g+e/URwBHkUyRxfgyL/8+J6SjdGNs1lV6k=;
        b=C2Up24Hn7D/hntIKbQl2QiyNvQ1megHTpWiYhynX4x7+3STqYhw+4QTtgbn0tFamfm
         AivC4xM7b9ijBu0knh5jlnwX9lq0MEruXbCuj6JnpYILK7lKxgsT/3ph7O5U66OZyIRl
         l9uB66//mrL8ZUvc/ICXzH52iQXgJ+HnE97itgCqSCw/RlCVJ3rDfnDYYERDZ14svSHf
         jrcZzVvpxjSba4dZ4VFmy2ZxXAJiLHTeGN/Amk3LI1lU0qJiwus400dDyo7+hszKSrNp
         Io8XKdXGg5o0qB5RlNsYyJkj8BIvU8ZtjnHIyf3X5rOuqHqB4+/OvewhXspO/npmJ57b
         oNrw==
X-Forwarded-Encrypted: i=1; AJvYcCVqzZOwN1a+dtIUADpXWZliTXWQwT6AIMeV6dV3r7e2ec2jq+dPZIIkhyWJ7tIIUUcueySHAYOoGQtLHTyflHvQcF/BgY9c
X-Gm-Message-State: AOJu0YzNbQs51krH/YjrDzmISqBzqMx8bOnQbBWLij1i3IgBQLMH9IBZ
	9FecT41i06jASfQ0KXMNOq9hfrBJzmXhJrSy+AgFpSSnLoMBLP1VGLSHSU0lddI=
X-Google-Smtp-Source: AGHT+IH5f+e3MJVYWHiUjrE8n7bmIn2cQMPAshikJkuBn7pk+1XQ9J4fIdhmiPj2xJz2vfmEJImlPA==
X-Received: by 2002:a05:6000:1cd0:b0:33e:76a1:d031 with SMTP id bf16-20020a0560001cd000b0033e76a1d031mr2170182wrb.50.1710146591277;
        Mon, 11 Mar 2024 01:43:11 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d44c2000000b0033e2b9f647asm5839597wrr.31.2024.03.11.01.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 01:43:10 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:43:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com
Subject: Re: [PATCH net-next] tools: ynl: remove trailing semicolon
Message-ID: <Ze7EG8_c_NDRdxK9@nanopsycho>
References: <20240308192555.2550253-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308192555.2550253-1-kuba@kernel.org>

Fri, Mar 08, 2024 at 08:25:55PM CET, kuba@kernel.org wrote:
>Commit e8a6c515ff5f ("tools: ynl: allow user to pass enum string
>instead of scalar value") added a semicolon at the end of a line.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

