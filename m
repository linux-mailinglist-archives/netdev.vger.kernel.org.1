Return-Path: <netdev+bounces-141725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF209BC1C4
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 01:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175F61C2133A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 00:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DE38F6B;
	Tue,  5 Nov 2024 00:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="twRx4sHI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC910F2
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 00:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764901; cv=none; b=Nrej3KZ4BCcuYufMT5sP1xp1meRQ7gd59zmgzWF0tmjHzCnnjGQRqoJWTREasP+nU5cg4wTNJNefws2Uoecyn6kArmnA3ptcdjiNmh4zJAWmiLk6Y9+1fiqXFa6osr3nNUWW+bh8NI0N7RyMQT2X+enG5Ahqs+Hg6KV2P880aZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764901; c=relaxed/simple;
	bh=6yI6UEYCEKxnrx9+/HaTpOpIPo4ib88NscvinntE2CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgyHXHC5ToKQd1t/hl+gQCbadTHd6Svn36T483ANJKWhFDo8z6WFECXtfpoJ9xBUg/RTiIg/VVceOm+myVOEiZXQmEumPTrAhBNDfCHrpqS66QXoy2uLkUckWFKXizY/NLV08H2MaDP7WbMaxdeOLebaXVAXRexLU16aDYD/0Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=twRx4sHI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so4206002b3a.1
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 16:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730764899; x=1731369699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiShwGNgjZXzIJw3EmcQvT2xIzvJnyyeh86E3dyA92s=;
        b=twRx4sHI0wz/woq772mlljvpYstU0YqJFG5KsNBnlET/7nJaLUOIRuKDQj5EPjk0yH
         22aMFWEJnGwsKYuI4wt11AYiej0byLAqDth0J4uUR0MpIWQxIXX0mAH6zOexcytI19ES
         j0HujcdW+rtt5/djCCNzP9N6fLNaMUdiNT9fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730764899; x=1731369699;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DiShwGNgjZXzIJw3EmcQvT2xIzvJnyyeh86E3dyA92s=;
        b=EnIZeqno5kMINY/uyX2dcbui5fO1p0sIzgib/DdjI38vM9BkCWEzRBbNti48D0m7E7
         C2SggLhgDhna3ErCJ+Gbhjon1MkCc0eXxTqaP718JgrlygJWd8BZEC41OAifJqAim6TU
         oIWtwsLnBUd8mAUgMcq2e0dmBHQHYF3ffa/gswVZr8eHqXfVQFpfCumMSZoxTlmCHPbg
         i88tFhXOYHSOgBlS96QWfBLsVkBAC4BZYqvy+F8XPjt7GFP/g+egrbkYjlPiD/283VNK
         d52G6OCgOfa9n63sjPVXQ5u0GyfoM8KBLoEBf4dAmWOMNntdJNU/dbZwe3UeP5imuXwz
         ePtQ==
X-Gm-Message-State: AOJu0YxbhUT/LNVsS0WBITDsppS8ul0IgsgPln5X0shoj4nX2n2+zvJ/
	jNzTr/c+XI0OP+eskOY4ttHCmdIfojNi8LLwUJH1ZQSlS1dLt0Z2Qz7cNyFXfug=
X-Google-Smtp-Source: AGHT+IHSdBpjRqV53YfC2PeU2ZEkln+b1qR+XerC9xeK/DFyQku0Yu13uWDphAHW0yUHzqmjnx+C+Q==
X-Received: by 2002:a05:6a21:1798:b0:1d9:3456:b799 with SMTP id adf61e73a8af0-1d9a8535d0cmr45172446637.46.1730764898939;
        Mon, 04 Nov 2024 16:01:38 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452aa17dsm7698879a12.34.2024.11.04.16.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 16:01:38 -0800 (PST)
Date: Mon, 4 Nov 2024 16:01:35 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 09/12] selftests: ncdevmem: Remove hard-coded
 queue numbers
Message-ID: <ZylgX5SzV_FExBJl@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-10-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-10-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:27AM -0800, Stanislav Fomichev wrote:
> Use single last queue of the device and probe it dynamically.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 40 ++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

