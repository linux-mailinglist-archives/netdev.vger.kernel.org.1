Return-Path: <netdev+bounces-268578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOxzNyY+uWkowQEAu9opvQ
	(envelope-from <netdev+bounces-268578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:42:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F8E2A9196
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F0673010BAD
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037B035F180;
	Tue, 17 Mar 2026 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gamghP8C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qnVY+glx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23CF34DCD1
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747440; cv=none; b=sFHEKKhcu6GYPdQ4eh3xCpwMEthpnTE8RrJBgOSOMf0oVsG/rloINkRkSTbXequVJwOFborLliQuzbJJcO4Vy9x8pfsPZe5pyuXpIPk+MXiy41A8HwhZVe/+l2foNEMDNJAqXOhOjz+VrM5H+t8Y2e1T5rKMnP35lP+cjKGf3Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747440; c=relaxed/simple;
	bh=5HV6z4bHFLNbBfcyV9bHXKPjl1fpAvjok3Roqp0mPs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVkdT58nJd4K+k1EJ5i1Wa+an/4SUAMB9ciG+2Eo8q5X349Zdpp3YhgIBJ211XQhccUQm7HjHpH+AW1quzAtfU3qvQ12YQid0q2OD8AL/E38MXtYiJgGKD3jxwROnWaVtzr5iKk5IG3f1BBGYO1dkskv+kfPiNDbR+3jzSvQegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gamghP8C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qnVY+glx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773747438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dq2eU6Fwh8wnXD0wsmW8g52vWTNneSdO+JhFXQZ/JP4=;
	b=gamghP8CGIbz8GElsGmcdyKA/tR4yMsWeEH1sbifU1X0sABYIuJXh5aAv8/rbYVDd1pIRv
	jbmmJwdBCRYngNQ+7mMRfNanEp1hs80KAZsXSaTyyhjL/D/f75CBbGmnGjOljNZIdPWum+
	o9pXlj3Ljrza1WuvqVaufTGJNTemSZ0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-6Ygc_KxqNMunS6gRToal0A-1; Tue, 17 Mar 2026 07:37:17 -0400
X-MC-Unique: 6Ygc_KxqNMunS6gRToal0A-1
X-Mimecast-MFC-AGG-ID: 6Ygc_KxqNMunS6gRToal0A_1773747436
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439bab2d095so3431278f8f.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 04:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773747436; x=1774352236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dq2eU6Fwh8wnXD0wsmW8g52vWTNneSdO+JhFXQZ/JP4=;
        b=qnVY+glxE2PXh1U06GdsBXVobHKiJvGvBdEacg3+KpJ8o1PF8IX861KlyRY0Q4alxN
         DaYdKZl/HInKEauQr9L5Wgbo8i0DSOT0jvAm6vcJU0p6T3QYQPh9fRfnGJNM+HTPtL+/
         Crq6FB98heRpbvK8vUFGFRq3JXymq5gYQBPiO3Vy/JutMAdZec5sOsS7XRoiaC2uO6gE
         ly40srtvzpgY42PTwm6y2fxBN9LzbrRCpHGoOV+ynmOICeDX5A4zYpQR+1YglW+WAQMJ
         3SKkO/eXFyPXPln9QW/egVCuPfSSVOk0BxivwRORAMha5WWXkHfe8zDSFrGlxtybG9dc
         y1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773747436; x=1774352236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dq2eU6Fwh8wnXD0wsmW8g52vWTNneSdO+JhFXQZ/JP4=;
        b=KqDaOthrYsEOdEtM0SJgQLhixr9qmb5VTNFWV5dPp/ijiApxoULqMovZTgh2QYu+5g
         g3I8wmXnU6c8s5caUvZqDNC2maWhcXediWrR7TNb7Eu9XxvKqGEpVLJJNz7EhRFQF8DL
         rkNu6Y8NpxX+0TtWIQAHxryNYy3jUlR+3DOA0YMoYYXv7aQdK1BVjhmkOETzzekCOzJX
         LyBQlrVTeXPwAY0gtUCH1rxEW/3BdwytxM18obf1fYcaf9dujCpg1IdYnpWgNCxoZdgp
         HF6/ZdGzytLp0LmMMAoGco6f9Y9pkFb73JMJe/6dyxSetb680J7cwqztBCYNiD+F+NIf
         8ipg==
X-Forwarded-Encrypted: i=1; AJvYcCWQlw61711TjS+dpSL0+T5OMrys0fCD8h9LKUhoXKOTXPH5++uOorA0/EMSbwKp1umiZhGWULU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynEvby1GYDkNLt+HF+aj+rJsadn+apPvzLnFQVLipowZuOUy9u
	PFRhBY8dA5z26aQAjIgz76LQZBrtXd45wWCWHJWJnILqRsQXrbJtBeArXnxOYvc2VcJZ86RhaUK
	WJNHD7pr9ShYsMF1Q3nQZCLNqKEylqT7dguLoN3pYhVy8SaUh9n+CR79P1w==
X-Gm-Gg: ATEYQzxBvbzK2s43UrqInEj50TPWP/vUTOfefsD2e0EUEb9gvNayINBbW2wMStR67u1
	QWyw6RbHCHb7g3sn/Bvq6HTvxiK1WkYXWnC15RewhO6K6ioLKfviFSder0fBhVlxOxfgJL7mZuA
	D9n0PaTyD1FUugBr2IXF56Yo+5V4q4ubz3w0+x9hp+KPlHXXT/AwIEKYDAF5kDZpsQUueGFkDbR
	oD8gHQ7F3kNs4HU6wFaJivsQzb2e36fyEzRJ4GI2sN/SvRjb2YV+XvUa/tnW2SG7bEIqfNxxBIp
	AphttF6J20Uky9F/twKQbosfupqgjZtereV3vZYU5VgaGl7u8zP8t5pDF3kqbOJFI65LTy0IV0I
	Bn/5vkBgnD4c+1oVQ6nQqRmN3zkOWWoVZmAN/ZB46y3deIgVlC0zYR08=
X-Received: by 2002:a05:6000:2882:b0:439:b636:1fa4 with SMTP id ffacd0b85a97d-43a04dcbd70mr29866040f8f.48.1773747435976;
        Tue, 17 Mar 2026 04:37:15 -0700 (PDT)
X-Received: by 2002:a05:6000:2882:b0:439:b636:1fa4 with SMTP id ffacd0b85a97d-43a04dcbd70mr29865978f8f.48.1773747435468;
        Tue, 17 Mar 2026 04:37:15 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe228986sm46926790f8f.35.2026.03.17.04.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 04:37:15 -0700 (PDT)
Message-ID: <726e1d40-6a29-4e6f-964c-1a4d0cf7d4eb@redhat.com>
Date: Tue, 17 Mar 2026 12:37:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 00/11] net: tunnel: introduce noref xmit flows
 for tunnels
To: Marek Mietus <mmietus97@yahoo.com>, netdev@vger.kernel.org,
 sd@queasysnail.net, kuba@kernel.org
Cc: Jason@zx2c4.com
References: <20260312155657.25676-1-mmietus97.ref@yahoo.com>
 <20260312155657.25676-1-mmietus97@yahoo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260312155657.25676-1-mmietus97@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268578-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com,vger.kernel.org,queasysnail.net,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77F8E2A9196
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 4:56 PM, Marek Mietus wrote:
> Currently, tunnel xmit flows always take a reference on the dst_entry
> for each xmitted packet. These atomic operations are redundant in some
> flows.
> 
> This patchset introduces the infrastructure required for converting
> the tunnel xmit flows to noref, and converts them where possible.
> 
> These changes improve tunnel performance, since less atomic operations
> are used.
> 
> There are already noref optimizations in both ipv4 and ip6.
> (See __ip_queue_xmit, inet6_csk_xmit)
> This patchset implements similar optimizations in ip and udp tunnels.
> 
> Benchmarks:
> I used a vxlan tunnel over a pair of veth peers and measured the average
> throughput over multiple samples.
> 
> I ran 100 samples on a clean build, and another 100 on a patched
> build. Each sample ran for 120 seconds. These were my results:
> 
> clean:      72.52 gb/sec, stddev = 1.39
> patched:    75.39 gb/sec, stddev = 0.94
> 
> TL;DR - This patchset results in a 4% improvement in throughput for
> vxlan. It's safe to assume that we might see similar results when testing
> other tunnels.

Sabrina noted I wrongly replied on an old revision. Reporting my
statements here for completeness.

IMHO this performance delta is not enough to justify this amount of changes.

Additionally, the measured impact of removing the dst_hold/dst_release
does not fit with my direct experience on the same matter: it should be
below noise level in practice, as dst are per-cpu and and no
contention/false sharing is expected in a good setup.

I think you are observing larger impact because in the veth test
dst_release can happen on a remote CPU. Note that this setup (vxlan over
veth) is not very relevant in practice.

I'm sorry I'm not applying this series.

Side note: if you are interested into improving (UDP) tunnel
performances have a look to big TCP support work from Alice Mikityanska:

https://lore.kernel.org/netdev/20260226201600.222044-1-alice.kernel@fastmail.im/

/P


