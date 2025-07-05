Return-Path: <netdev+bounces-204288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24E0AF9E9E
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 09:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0263AC9C6
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 07:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381F21F91E3;
	Sat,  5 Jul 2025 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ2g3aM0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2464319DF4A;
	Sat,  5 Jul 2025 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751699806; cv=none; b=hww+PTisFr7wMghX4Qsh1pHmJtFaBfKqS09tWGANZ3NhSfbX8delA/7JLDcdR2mEybcx8gq7f9YgN/Y2zo4/zWUXYXl5xZjrajKLXCXYqtd17VXkJIvjLBd5HxbXvSwNrT+ie6orysg7w39P3QH1Bf8Y4aUnxhatOnxkhgmRP7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751699806; c=relaxed/simple;
	bh=tUhWmgK4dOMTc0iS2htVf8JYMWc1HQMBTCCneavHgjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWZcbkeKirdVJXO0meHNm5BbiXFTollkYRRJ85t5zePfeN7s7A0hEE0CW+p3i0XecvEgqBDGCqpyIeaNbE6tpE9J8MSLsUB5AKk9wvN1We1vHdA/VYFoLsjUOMeA/BOANm98WsJr+kt2IOKmqDYOhbZHEoMbJ8rvo+HU5smDVLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ2g3aM0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4537fdec33bso9008665e9.1;
        Sat, 05 Jul 2025 00:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751699802; x=1752304602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R5oTgaAPwIE+ySog9Pi/wJSy7DIcCAi0+86Q6mHWKY=;
        b=iQ2g3aM0O+1MIrbxY2HjshMIKaIbeKaBxPnQRcZ69/gQjdWptmpArdTLnvjOp6jZIY
         VHHE7+pZhUEpwB9l6iqyqxIcTWY7Mzzf86pTvPPXfgZ7DiUTzFGSWS+5+v34jmDbrwqW
         TTRb8ZSnEr0yNX7nJxFPOaomJS2MDucRQBaI9r0ioaCbhgaFdH7zLG4VgfSlIyVIHYr1
         yeCTQ+tR3kHuwGLXBgFbUWdrRTJ3fCEvgBHoR4o/JN9s79XQqwzKAt7Y9Wg38XGmhSvI
         aoyWqCNcmj9Ofuge6ELxHnrZJMkijrwvB9IcHvipAaqg1WTMUMppEiF3z+DAw9gmispF
         O+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751699802; x=1752304602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8R5oTgaAPwIE+ySog9Pi/wJSy7DIcCAi0+86Q6mHWKY=;
        b=m8a1NOrwWdcaFvk3aHKxUFbsF7uJmrEcZ8pxosyfI7bx8RXALNcpxB9X9Yc0Zl/tsm
         UOJYHBtZKH6QqlHp8R2RamgHvLZkDf8kKF56c9WOhemlNTjLCGk6oaKseKFR+SE7KPuj
         lDXfSDjMD2PHAWbPXgKDpAQqFjdBASf/Ybf4LRGzVukqpYg/YAd2V1l0lWZZ2pIkcPiJ
         MXgyDdgQKDW3tCKpu+ZOp9A+2UNxc0Gr3gFRZMlLCjDv0s4g8jCmgxJcMEw7+hDhQL5y
         XcJgkbl8l/+A6smc7BAS3ZIJxFVNFNZ4UR6W8xWlqwGTeJPMEnFl6ehet88sEZmgtYmw
         oswQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6t501G9jqXUv6VRYN4+3fCfc3gtIQlE36WFnl2BXrZqiOig7/RNP4H6ZCzUIjm2mf9x35VtQa+HbynfE=@vger.kernel.org, AJvYcCXE01j4xT74EqwRbiNNELHcY5W06qNA9FB76YWXtI/NV7SOGgWVKo1eDWniljHZCxe7NSmmzEbn@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3ydBa6r0sslBLip6mLgobAEAbHRxDZRaLGqh6HNJt7WMNpaP
	cdq1HI1/6/O4RiGkZn02dRFOgth9sIBHNTaqRkIXwqHWphj1cPGzqA3Q
X-Gm-Gg: ASbGncuzxrRoZcj9V2hN2hpBgmtZo9PFyzshSDx/QYNc0IJdbL8ViIsqhP2T13NpFkV
	pHCj3rUt2d7t0MBF/d2G0+PPoMNkuBUfN1SFaJ9e8Mlv8SiqOft+RBZCLTwDMxUo3//UtwMJVC2
	NTD7KQF7adkUaOqPyiVvNEal7B4QyZ+eSLHCCZ+XNxWOeUkzELQorDcO2Tfwslwil3/BISLZnQ+
	YJtob+jV4sEzM+NwXaTlClGjU78xoUHyM9LiW9fo+4r2l38lJkS5OTCA5cX4jpB5rX0HDvVhCGb
	zqFQQobuIr/lvX7gRv5xY0B7FTckW54z+KKvqP84yff6/0t0ONDeZrS/ojtHzSxsY644IcS0LmR
	qKFMwfl49tleurYE2Mg==
X-Google-Smtp-Source: AGHT+IHXEwjcjQ9NX0f8W1fKeEpMnHB2PDebEu/auXAypGG0r6Beul+slgLTogHrnsvnqSeFZur0dw==
X-Received: by 2002:a05:600c:1c21:b0:453:7b2b:ed2e with SMTP id 5b1f17b1804b1-454b4eb7e77mr42866925e9.24.1751699802184;
        Sat, 05 Jul 2025 00:16:42 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9bdf038sm76279665e9.27.2025.07.05.00.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 00:16:41 -0700 (PDT)
Date: Sat, 5 Jul 2025 08:16:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Feng Yang <yangfeng59949@163.com>, aleksander.lobakin@intel.com,
 almasrymina@google.com, asml.silence@gmail.com, davem@davemloft.net,
 ebiggers@google.com, edumazet@google.com, horms@kernel.org,
 kerneljasonxing@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, stfomichev@gmail.com, willemb@google.com,
 yangfeng@kylinos.cn
Subject: Re: [PATCH v3] skbuff: Add MSG_MORE flag to optimize large packet
 transmission
Message-ID: <20250705081640.232efec3@pumpkin>
In-Reply-To: <1a24a603-b49f-4692-a116-f25605301af6@redhat.com>
References: <20250703124453.390f5908@pumpkin>
	<20250704092628.80593-1-yangfeng59949@163.com>
	<1a24a603-b49f-4692-a116-f25605301af6@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Jul 2025 17:50:42 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 7/4/25 11:26 AM, Feng Yang wrote:
> > Thu, 3 Jul 2025 12:44:53 +0100 david.laight.linux@gmail.com wrote:
> >   
> >> On Thu, 3 Jul 2025 10:48:40 +0200
> >> Paolo Abeni <pabeni@redhat.com> wrote:
> >>  
> >>> On 6/30/25 9:10 AM, Feng Yang wrote:  
> >>>> From: Feng Yang <yangfeng@kylinos.cn>
> >>>>
> >>>> The "MSG_MORE" flag is added to improve the transmission performance of large packets.
> >>>> The improvement is more significant for TCP, while there is a slight enhancement for UDP.    
> >>>
> >>> I'm sorry for the conflicting input, but i fear we can't do this for
> >>> UDP: unconditionally changing the wire packet layout may break the
> >>> application, and or at very least incur in unexpected fragmentation issues.  
> >>
> >> Does the code currently work for UDP?
> >>
> >> I'd have thought the skb being sent was an entire datagram.
> >> But each semdmsg() is going to send a separate datagram.
> >> IIRC for UDP MSG_MORE indicates that the next send() will be
> >> part of the same datagram - so the actual send can't be done
> >> until the final fragment (without MSG_MORE) is sent.  
> > 
> > If we add MSG_MORE, won't the entire skb be sent out all at once? Why doesn't this work for UDP?  
> 
> Without MSG_MORE N sendmsg() calls will emit on the wire N (small) packets.
> 
> With MSG_MORE on the first N-1 calls, the stack will emit a single
> packet with larger size.
> 
> UDP application may relay on packet size for protocol semantic. i.e. the
> application level message size could be expected to be equal to the
> (wire) packet size itself.

Correct, but the function is __skb_send_sock() - so you'd expect it to
send the 'message' held in the skb to the socket.
I don't think that the fact that the skb has fragments should make any
difference to what is sent.
In other words it ought to be valid for any code to 'linearize' the skb.

	David

> 
> Unexpectedly aggregating the packets may break the application. Also it
> can lead to IP fragmentation, which in turn could kill performances.
> 
> > If that's not feasible, would the v2 version of the code work for UDP?  
> 
> My ask is to explicitly avoid MSG_MORE when the transport is UDP.
> 
> /P
> 


