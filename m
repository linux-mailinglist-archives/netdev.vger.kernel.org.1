Return-Path: <netdev+bounces-160045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA38BA17EC1
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7B33A39F2
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841471F03DF;
	Tue, 21 Jan 2025 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="IQxXgrHS"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27B1F2C30
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465640; cv=none; b=oNSe1/QkGzCn2UmEtij4K2qNhSyeqPf0Us+dbtLuTUZd4gUUih/U4mRNmWuzQtcNCfUExhD9Ods2CM3xxRLcXu+sg2uPpMqRs6qjF+1PrEPZMg0wHhIKpjQHurOUdgx9aQ5vS4zg+fMPC+rBZ9qKSBYDD9/m93Igaq89+FTkAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465640; c=relaxed/simple;
	bh=cgG6mmM7dHyBeIEjdsmXmq69rECp2zgcWZKPmNBe43c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrApAHfE6KKvbT1KjDBCVr7EX2ATxYrFm6o1eP1zd7wa8wkc2yECKEU+j/2xqcctA4Qs5G8fR1RWebqBk97545loFDyyk6+GWjM6aMevpQUaZtq1EU2/FyusctvIFBMQy2vFunsfeD7sdINKk0UxzxiH1T/xd3SAohPDYoa5knI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=IQxXgrHS; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1taEB5-000alp-UA; Tue, 21 Jan 2025 14:20:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=Z6QL63bWAWrxhlEioP96EXR3RT0eLMG+NzQPJYTYZxo=; b=IQxXgrHSVLpQsykK+IxGSLKR8f
	hk8Fknvu22pPVuCwo0R8cHyn/Da8PiPzdWUvMys+4cGHuCzL2cXuf/npSzoaBM4SscIxNUmDAR+Ta
	26qxqQ1q9XeTTvCgcNJLVGDZUMsAwCMExoBGEsQ0RQsQFvpcCKOYXScDBuJQQdf1Q19ZMIsb4/7Xq
	NlJbH3xXZ7proFbL9I3S5/YLVzUFX1GNACoFE83jVxV4TENJV3OSV4cip2CR/X0H+KSNWnPHtxefc
	RbN0i58euyyoj0V82lphsTWSP5Vz/BsJZlXMuIqh0Qu1PmqcStchOZnzwFjiP+6EEfpXbqaR5VAre
	KBEYWWNg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1taEB4-0006II-CT; Tue, 21 Jan 2025 14:20:23 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1taEB1-005Z0Y-3H; Tue, 21 Jan 2025 14:20:19 +0100
Message-ID: <caa2f86f-92a1-4b7b-b37c-bb8e4e0e3971@rbox.co>
Date: Tue, 21 Jan 2025 14:20:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/5] vsock/test: Add test for connect() retries
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 Andy King <acking@vmware.com>, netdev@vger.kernel.org
References: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
 <20250117-vsock-transport-vs-autobind-v1-5-c802c803762d@rbox.co>
 <pyun3hl67vjel7gc7k67nvelx5bmgw664gvkzauqqv6nkkt5sc@x6hzsedofchl>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <pyun3hl67vjel7gc7k67nvelx5bmgw664gvkzauqqv6nkkt5sc@x6hzsedofchl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/20/25 11:24, Stefano Garzarella wrote:
> On Fri, Jan 17, 2025 at 10:59:45PM +0100, Michal Luczaj wrote:
>> +static void test_stream_connect_retry_client(const struct test_opts *opts)
>> +{
>> +	struct sockaddr_vm addr = {
>> +		.svm_family = AF_VSOCK,
>> +		.svm_cid = opts->peer_cid,
>> +		.svm_port = opts->peer_port
>> +	};
>> +	int s, alen = sizeof(addr);
>> +
>> +	s = socket(AF_VSOCK, SOCK_STREAM, 0);
>> +	if (s < 0) {
>> +		perror("socket");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	if (!connect(s, (struct sockaddr *)&addr, alen)) {
>> +		fprintf(stderr, "Unexpected connect() #1 success\n");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	control_writeln("LISTEN");
>> +	control_expectln("LISTENING");
>> +
>> +	if (connect(s, (struct sockaddr *)&addr, alen)) {
>> +		perror("connect() #2");
>> +		exit(EXIT_FAILURE);
>> +	}
> 
> What about using the timeout_begin()/timeout_end() we used in all other
> places?

Oh, right!

Thanks for the review, all remaining comments addressed.


