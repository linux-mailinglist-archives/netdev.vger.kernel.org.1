Return-Path: <netdev+bounces-184809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CFEA97440
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C257E17FD44
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7641A2820DD;
	Tue, 22 Apr 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyswBVMl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A91DDA1E
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745345275; cv=none; b=hBcQaFfGLEBwpGn1ZLo9R/olSQ8YTOaoHSy4IheBU7nEa90/WvOejRmgggHdfRrhGVtHaREk4eAv6fufvUWNIofmWWKwsoCsoM8PKf6p5+LMkoa4zgHQenaLHkV50XYu/vZsJ8A5v9kA9aPcvvP1JKP6eCDTLlj0m8+ByUPHuS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745345275; c=relaxed/simple;
	bh=frb0NUp+bf9GS+52khl+rBh3rByN7xtPicT7VLysy9g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=S/pk5Q7uyR19ldTZWKb+7jN1IcSd3u8/IQkkFJYXa9OVW3mId7llso9tyIaRf+0AZupnqTX8ANkPk4CeB7Aj8orBSZiupvu9vFqLReVCgNuTo+HuTk8G5uQ/Dl6Y8sWDYixLPTGwQ1g/V/PRho96pQIBfvOPQDwM8bIRmIMBVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyswBVMl; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so1847016d6.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 11:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745345273; x=1745950073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7Am1Otmk2sTx7fhaAloqfc4F1gNM8k+d+6eZKvOwSo=;
        b=LyswBVMlZSy14aTLSk3Ue+WftLxZjc6FsWaGXilrpcI9LsnXChOusMw9FBfI+4HAYr
         yorAsqiApieXfm9FQC49X7YX6Ftjo1VCZNkzie5hq1MPVoKz1hy3LdBTk+FavfBzrOj2
         BJpEQfzgZ/XwirAktjcQkjr0CB4tjIMx4smro89dfk1MFlNUgl/ESFYGCL4qyPFyYm6E
         ssLEdV4aem1S9t8cHCJazn/0X6/qREmF+vSzWXGtn8qze7/H0ctX+r4e9RbOOS8Ubkrm
         AU2eXrzteW6ojXyOOCBWpr9Zr0XcinbQadlX7lQg1jNzLCwrqzbCglmniioaKnydue84
         +Gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745345273; x=1745950073;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x7Am1Otmk2sTx7fhaAloqfc4F1gNM8k+d+6eZKvOwSo=;
        b=rJl9krKBgXHsJt2pi40FtF7yvZrQAOxkf0kDR9EOEb8nduFhps9iccbGybt/jDqz9B
         GOZPbVlP0weJhgGLFDfdKXIigUucZJAAFCQPZRjkcQlYVgFbZk1Zq0PK0q7MwEbBc95V
         oifIQ6B4MWMRqVz/4bkhe7R2cFU5w6b0UHmwBbUHqLoKx+DHBuq2ArwtYihClpgxyVrZ
         oL4+5ouVwhCZ65KnwrzfmHXLWNZUaIsc9teQV02BwygKU9dQhnoDc7OUAEIwaAw4Xu1q
         yP0/A+tyrAzEvpIvK3O7PF3EmFW80Ff6lnjL0/GMjzx3eBDnOP0CMuPkzcdIKtIjTcyU
         22mA==
X-Forwarded-Encrypted: i=1; AJvYcCVP2rDu0wdcxMttJtRq9qzr5eUkCthSFAOBvLm5n/9Jy11ZNRhI3Xl+BcUM8JnkjYDGR8FfBN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfQMQ1wBMam9iWatWALbvd96KcmkZmmpCfgEpx69cmBG0yGSan
	D0yGlTElwss1hyXRvll8TaCjE4Zoozl9GZwldHZEQShJRfAHdc0t
X-Gm-Gg: ASbGncue0eykN2ofF+HF/o0cSZte+H/bTmnLp49y710pyj0l0PMPJZqO9031YtH/MTd
	SMKA3zxRdo/JcpA590DoM2X9A8mupHc7KHnE9+qSDc8pQ+GPF1I4wKUe+60o9ym6ERcJKXXJoEp
	Vzfaaw7i6LepCx7TLEfGdtePycyt9GZNT68eMqjuPkY9RzFn3cNXwVhQwqBGXUf8//8YfSZUpOx
	h4R9uvqyyTV2qzb9+XC5HDAX/LW2lyrn5Pyu07BpqRTBI8M2l4wFBiqUQoTlsgGiv4AFzjf0c/K
	7ClWCr/k+Lp4QtCpauufKNxBNZgal7CKq5GiShFU+vJFmZDnlQWu3pgarnbCMT8+y/AVYzaqvqJ
	dO2nT06ua1wWn/Zf4ieA8
X-Google-Smtp-Source: AGHT+IFJzJuTZGBrkBiyg/dWVPkuOLZHNsVJbcaj+sZWFAHuPwIqkEqTTBCiROKUZI3sKImUXqUJig==
X-Received: by 2002:a05:6214:d6d:b0:6ed:18cd:956d with SMTP id 6a1803df08f44-6f2c4f23ec3mr261779576d6.22.1745345272623;
        Tue, 22 Apr 2025 11:07:52 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c925a90c3fsm582955385a.46.2025.04.22.11.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 11:07:52 -0700 (PDT)
Date: Tue, 22 Apr 2025 14:07:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: David Ahern <dsahern@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 idosch@nvidia.com, 
 kuniyu@amazon.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <6807daf7d73af_3c1f7529461@willemb.c.googlers.com.notmuch>
In-Reply-To: <84a4b04f-492e-4004-8fb8-25464aea56e3@kernel.org>
References: <20250420180537.2973960-1-willemdebruijn.kernel@gmail.com>
 <20250420180537.2973960-3-willemdebruijn.kernel@gmail.com>
 <84a4b04f-492e-4004-8fb8-25464aea56e3@kernel.org>
Subject: Re: [PATCH net-next 2/3] ip: load balance tcp connections to single
 dst addr and port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

David Ahern wrote:
> On 4/20/25 12:04 PM, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Load balance new TCP connections across nexthops also when they
> > connect to the same service at a single remote address and port.
> > 
> > This affects only port-based multipath hashing:
> > fib_multipath_hash_policy 1 or 3.
> > 
> > Local connections must choose both a source address and port when
> > connecting to a remote service, in ip_route_connect. This
> > "chicken-and-egg problem" (commit 2d7192d6cbab ("ipv4: Sanitize and
> > simplify ip_route_{connect,newports}()")) is resolved by first
> > selecting a source address, by looking up a route using the zero
> > wildcard source port and address.
> > 
> > As a result multiple connections to the same destination address and
> > port have no entropy in fib_multipath_hash.
> > 
> > This is not a problem when forwarding, as skb-based hashing has a
> > 4-tuple. Nor when establishing UDP connections, as autobind there
> > selects a port before reaching ip_route_connect.
> > 
> > Load balance also TCP, by using a random port in fib_multipath_hash.
> > Port assignment in inet_hash_connect is not atomic with
> > ip_route_connect. Thus ports are unpredictable, effectively random.
> > 
> 
> can the call to inet_hash_connect be moved up? Get an actual sport
> assignment and then use it for routing lookups.

That inverts the chicken-and-egg problem and selects a source
port before a socket. That would be a significant change, and
considerably more risky.

More concrete concern is that during port selection
__inet(6)_check_established uses inet_rcv_saddr/sk_v6_rcv_saddr to
check for established sockets, so expects the saddr to already have
been chosen.

Inverting the choice requires matching against all local addresses.



