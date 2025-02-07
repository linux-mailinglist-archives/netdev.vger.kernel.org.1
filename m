Return-Path: <netdev+bounces-163737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9541A2B726
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E68166C81
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE62D26D;
	Fri,  7 Feb 2025 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ox92AzEq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB845C96
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738888229; cv=none; b=mnVcmiw719+DcgY8hBylfzVUl/5L7yJcav/HQ7U2j+QNXXNpaHh0RleePjk2AyuV0Stn3Ddkkx0LTxDx/21vTpMyk9kCRexL7VG8OxX44VMebLUr96FrBTjjdDm+IMNgtflQR9ghBZI2gx0GEeZs98TTYvR8vC+DjfDlNb/B02M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738888229; c=relaxed/simple;
	bh=8EQR0kMHpW6ip+B/5ka0Zjg6mrVYsE7gKMJmLqU4K10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ing4Q2Z5cfKTWFOhikqoZJOWvzcwIbXesQf6RtmlPArKgVXTyaY4OQ+sl7NWGgrqmglm6isJyLMwgnvymKdyl6mTkM30pD142g4E2CX6SU0gVCqqxw4OvTnqy3ybB6Sfh2llyUjcgIkgvdulWHBUCsUrptblqndJfQoIvj2DBn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ox92AzEq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f4af4f9ddso10131265ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 16:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738888227; x=1739493027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VU+BVBsazC2y8+Coh9plQBMZRLjj+33w4+3+y84wivk=;
        b=ox92AzEqumgnfAFBXxFoOxfKw5o0nOb7BBFU6fLNut4jNmyEYw+Zy47tuJaxiFhDAj
         ACjKaqBm6NDam1miBL0kP0n9sr0xA3yTdCUFYMXEg6XEDiSwZQYZW4PFv1gUJVfpnogX
         itlJOT6f1nIVD8HGSG4ZVzheEiPi/bt+qXMDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738888227; x=1739493027;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VU+BVBsazC2y8+Coh9plQBMZRLjj+33w4+3+y84wivk=;
        b=XdCnTJXgjIiJyd9HhqtCsMEuabJHAcbxcbuYO5rMnNZp4Td90C19xmWWjqGKxXAe83
         tjuaPatRzSUKc6PwotunSvN1ZHon31VAwbnvrWQdwsRrbox9tk4s28qIQ7OpS8ap3qY+
         SR0tHfs2JlRdyvc4+NizHbFdkhb/tF+iKDU+8JbROtUYVfCNxvOGGm5kS1l/I52GRQx9
         h0IxG9G3z+d6MIZMj523RnbfvZ4ZSJnm4Tuik8i54HmJF601VaAB/wLQdTcx95osVlOu
         XdQYIJPYV0NptvkBVJTHoLxfnYEfzuWZMXiUwDPp2sT+ag1/jSgU0ITaUWVHNNmDmo79
         BF6A==
X-Forwarded-Encrypted: i=1; AJvYcCWLzzN7PwKJmPzMd9FRgS9paARXnEVEK6oxQkoH3YyqQ42+Kt4Xj5vZtHwtN/fRdW59N2mq5Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnvu3QRHuNQTNBgQpB8GgzB5t1nA8CjyoifJbZ8cfHPn97tLxe
	G7Xp083IjnzYxRjApIFQVUirTzpDEpWZAK74xy919CG/oLzY2X3HYJws3hJXhpQ=
X-Gm-Gg: ASbGnctv+i9A1HY9cyrsx1SjZE5nuf2rVNmZQDL133iqlvyLnuCJfKgQU0ToFzqFTmM
	rWh7gBIKJNLG+tbB3ta0LV8E/s3FoM4EhaJ85rOd7grU69jlSMa/9F/FEHjCB4h1xxrwjNzd3Ea
	rne5gaTd4n9XJRhuN29Kp4XFje5tpfQE4R0YMGffACzl/N//UibY+Oy/ZZfyUJHFJY2GXHSbupu
	ZIsaeN38PuK8J5uEXJOw5DyNuT0AcbG6iB+5myshf9GA6n2qwALHQLTcRF7+Rs35dy9JjTnLdE8
	vGt96uprFJq1Tpo5W4eGfNC21/oK1s68fzalEMtHv9dQR6QvfeC8GCq86g==
X-Google-Smtp-Source: AGHT+IHgJLQfaSgr8xf0M4q/0m9oc6NFlO93YPIK3SjEI2995m++1KM2YIr+t+qMt6hNQP64wpYzMQ==
X-Received: by 2002:a05:6a20:6f09:b0:1e8:bd15:6801 with SMTP id adf61e73a8af0-1ee03b5a981mr3134725637.29.1738888226984;
        Thu, 06 Feb 2025 16:30:26 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51af64c1dsm1913586a12.52.2025.02.06.16.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 16:30:26 -0800 (PST)
Date: Thu, 6 Feb 2025 16:30:24 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Neal Cardwell <ncardwell@google.com>,
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: do not export tcp_parse_mss_option() and
 tcp_mtup_init()
Message-ID: <Z6VUIOXPMezmNXzh@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Neal Cardwell <ncardwell@google.com>,
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
References: <20250206093436.2609008-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206093436.2609008-1-edumazet@google.com>

On Thu, Feb 06, 2025 at 09:34:36AM +0000, Eric Dumazet wrote:
> These two functions are not called from modules.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_input.c  | 1 -
>  net/ipv4/tcp_output.c | 1 -
>  2 files changed, 2 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

