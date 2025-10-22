Return-Path: <netdev+bounces-231611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6D0BFB7CD
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 12:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4A21892B8F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 10:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE5A32549A;
	Wed, 22 Oct 2025 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgETvft1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AF4325489
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130615; cv=none; b=IozOC2nFYKwWyv1FgGekSKgOOjvi6zOg2AMgh9zSa1oY2zq6ax4dOIlIH6b8wG/9d1IDJEVzjeC3IxLjNFSokFEq8k9jahm3tIdpO8/WXqO1925BwCiTAan4UOk9WL/utjAtqhT+RL9CKhsyHuA40mQm6mESkOA3kpy6DZJ4wR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130615; c=relaxed/simple;
	bh=+OQhCvBYkTpaNWYG55IZVFDwsdOq0gp6aB1fewv6Sx0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lRW1f8PE/hr5TNCKCrHZhXeW/EWduEceKZLCgPvDaLxOcoJR5sCnSMdyc1sC2ackE+aMPOapzls33R/Bp7oPJAzzaKT8B+mRhXG6IbXir/dRtZm/BDmwgmV+XvujSwHa68hp6t7UDFIBiTsg+yU6lLHw4Cf//bopUMD16qGb8L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RgETvft1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47495477241so16963825e9.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 03:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761130612; x=1761735412; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w5Yq6CrB7/8ZGzQ8ZrURUA4zqj0X89zvbStvTznlwuA=;
        b=RgETvft1UlaeP08tvnc908Oyclhl9wTe54Ch7CqURZ+CL+tUZpDyOUHhmGOftusPsf
         nB9YIso98OXkda1obe+Fo/I54IC0wG8JqOspyD47YHtoXB9vv4zwg6uuJIAl/ljsw7i4
         gZAINjbDX/WOI83QXx5lfhDR+E9hC4e7s3NMVolWqdrZfzac8QAX4nO8lO5+nkR0lFKj
         5mGTex6z8WJ8H+jdFH7o535+HLvfP/ZFuormVU7Q3M6TAilcKKySqyNYY1Q17LCjmClY
         oaS7UTCB2fCmpzWVNo0huoaa0+9RxgJa7H0RVuTcdmNJenwgKIiKfZMDQ3GsLnauyTAc
         HW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130612; x=1761735412;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5Yq6CrB7/8ZGzQ8ZrURUA4zqj0X89zvbStvTznlwuA=;
        b=S49xqbFgXj8RQ8CjpzKWnCSCcSqbjNM+3A2OEKVys7by9HYzStwPPgirayf90FKeNm
         EmXCvAILTmP0qo2y24qYlFe3PJR6ZOt3QdyKTiQzW6uEjTkusTOJ87+PO0VehGIF+crv
         V4TmbiucfHNP1W8pwNZGQyIHTMQGjpbdI2+xa5ddU6aYvM9h8XglWyavwNaIG5c+3E1X
         NS0PYfD/IScQdokek+boMc4Y/QXd/qSdrUZa01B4ysAgdTwAQayB2jTbQKKvxqo4HKoo
         X+0pv7AEtmOFUHrBS2Nci2tlWTBpfhFgm4X9X/a0ocfIeSeIqQsqxJOj9xY3iC86PRTM
         yA3w==
X-Gm-Message-State: AOJu0YyqwWM31rYMIn6J8MEV0+knxdkhs0c1bK+5Lno27iW40nQNsKWK
	zhKhRRvzS/Wu5fEclQShTPYXFvCGrZ49w6ROOfNHpVKwRVjjsHB+P0mA7l/UFjThiqE=
X-Gm-Gg: ASbGncvllL1zTotNSNcTeoSv11+jqNOJovVZbCy3LGuL18ubSfBshUIPPXnGhqpT+2q
	l3CI+zviNRjKNdwwu9897sv6nFVfp1Kq8MPcDAdNOw5XRKtgZaJb83cCCIecx/K1vlmmTvDg+XS
	ifgXS24xtoZG6O69haoyYPUJo8jfa1UBHFHtRtAITdJU3oTSehyXB/gwDAgrVPwmN0+u8toy7ay
	2pDEh0I12A7ByL72rRIOJZhmxOOYqAF0P6XWbHxD/HPbHhPL0uplowB9ozjaWsGqQ9perYnnnwp
	FcB59b93oAikcgDzw18R5+wDNUvC18/1PFacr109LFk0c+vAvSToVD5VUFbTgZYEM0xyInuALsd
	xSyz3/GgYVCDl9q7An10uVpj/8bKSOZuKTROxLL8VR7MgDf3bjLsPS29VPk8hmBEMKn8zVZlFQN
	tUdVKTzhz5U0YJr97g
X-Google-Smtp-Source: AGHT+IF2HsKdNWozp3kks+JuugpR+yLTWHUECd0/Tb/1+16TX4IrhWmgDDoUB2ZA7B8/GIbMyn7Xyg==
X-Received: by 2002:a05:600c:4e0a:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-4711791cb96mr160237355e9.31.1761130610899;
        Wed, 22 Oct 2025 03:56:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c428dafesm37369885e9.6.2025.10.22.03.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:56:50 -0700 (PDT)
Date: Wed, 22 Oct 2025 13:56:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org
Subject: [bug report] tcp: Convert tcp-md5 to use MD5 library instead of
 crypto_ahash
Message-ID: <aPi4b6aWBbBR52P1@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Eric Biggers,

Commit 37a183d3b7cd ("tcp: Convert tcp-md5 to use MD5 library instead
of crypto_ahash") from Oct 14, 2025 (linux-next), leads to the
following Smatch static checker warning:

	net/ipv4/tcp.c:4911 tcp_inbound_md5_hash()
	error: we previously assumed 'key' could be null (see line 4900)

net/ipv4/tcp.c
  4884  tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
  4885                       const void *saddr, const void *daddr,
  4886                       int family, int l3index, const __u8 *hash_location)
  4887  {
  4888          /* This gets called for each TCP segment that has TCP-MD5 option.
  4889           * We have 3 drop cases:
  4890           * o No MD5 hash and one expected.
  4891           * o MD5 hash and we're not expecting one.
  4892           * o MD5 hash and its wrong.
  4893           */
  4894          const struct tcp_sock *tp = tcp_sk(sk);
  4895          struct tcp_md5sig_key *key;
  4896          u8 newhash[16];
  4897  
  4898          key = tcp_md5_do_lookup(sk, l3index, saddr, family);
  4899  
  4900          if (!key && hash_location) {

If key is NULL and hash_location is zero

  4901                  NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
  4902                  trace_tcp_hash_md5_unexpected(sk, skb);
  4903                  return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
  4904          }
  4905  
  4906          /* Check the signature.
  4907           * To support dual stack listeners, we need to handle
  4908           * IPv4-mapped case.
  4909           */
  4910          if (family == AF_INET)
  4911                  tcp_v4_md5_hash_skb(newhash, key, NULL, skb);
  4912          else
  4913                  tp->af_specific->calc_md5_hash(newhash, key, NULL, skb);

then we are toasted one way or the other.

  4914          if (memcmp(hash_location, newhash, 16) != 0) {
  4915                  NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
  4916                  trace_tcp_hash_md5_mismatch(sk, skb);
  4917                  return SKB_DROP_REASON_TCP_MD5FAILURE;
  4918          }
  4919          return SKB_NOT_DROPPED_YET;
  4920  }

regards,
dan carpenter

