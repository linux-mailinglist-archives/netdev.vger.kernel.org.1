Return-Path: <netdev+bounces-217002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028FCB37006
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECDC8E3B8B
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07303164C5;
	Tue, 26 Aug 2025 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODQINFJd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EF39FD9
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225038; cv=none; b=tKsAZF3HcpaAM8U2YkYv+ITgwHsxUYVLSrcGK5loBL0cn5VcjxX0ihCJ8/cWPR4tbH2IC2nwBPD4J5m6SUn15rpmZJWhI2n1F6n07d2Uk/SCe+xgTFox9LiIWQmeuqHVSPw4HCr92IRzk523RGTyZyrHECd5AGtv5ItrGgr3nJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225038; c=relaxed/simple;
	bh=X4rJZfHelLtW4kAljhPw+wOfc6Wit6OmCPYcbQE9drw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArTGGoWqWo5C8yHme8VIUlSjbsRGw0te1ZrUyk8tkrl8aymNlkXT1ZAL22MeriFtcKPFsx72HyN+8+XTC9Bn9sS9rhEEjQMYfkCCaZ66ixICoTt/Vm9+al33VyiymdCkHdvyiKitcuviKD1Bfh1msRakY66bikRZlquFPhrcPEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODQINFJd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756225035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQD4x7//hMaxWvIhnPOEmLdTTFc0kGImBjXwi7ePdOs=;
	b=ODQINFJdy9o7tS/Pite9bER8OWLv22EgTYwuS+NoLKsBRVzKZ3/SwtMod9XUwgBcRpAzkG
	MBkk2xZHkYBVIqV6YU9k5FOXbNw3rV//U1qPRA8lkbHXq92FmgyBVPNfXp+yK40NuJADEe
	vjEPnDLv8JGntTuMJ3NhLzQVeS+M/WU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-zCpGj8n7MoOnl_Sw2MsGaQ-1; Tue, 26 Aug 2025 12:17:14 -0400
X-MC-Unique: zCpGj8n7MoOnl_Sw2MsGaQ-1
X-Mimecast-MFC-AGG-ID: zCpGj8n7MoOnl_Sw2MsGaQ_1756225033
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b1098f6142so113030241cf.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 09:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225033; x=1756829833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQD4x7//hMaxWvIhnPOEmLdTTFc0kGImBjXwi7ePdOs=;
        b=Rswnz3EsplAuVdyPRBIQ46Gi6lDlXDpAb/MDepXUizkZHf2NohvPE951i85bJMzoQU
         +8roH/fIlGesvi3Y7ep2hj3wjF1kojv3n6C3WTl0/VR8Zk+TmOEXs2rD7WCr/T/J5xr8
         bgM9qkd0/6q2gRiBIXY+1x+gOO0l0SDpuVXF5BiJ5modxguAwOYMfdENATW6qJauehCT
         tff7tICWCS1iZX4ujsfMug3Z7cLcM/EWjBSScmpVn994wi4qLQT4yHviIlyu3mFTr3P5
         Zkj4iSQkli7FP+lXpkXv0baO8AmRbaQHe1Re4XBmE4Dnh1wXH7wj9QGVA7cn1hgh9nLr
         Vjbg==
X-Forwarded-Encrypted: i=1; AJvYcCUbPzIZwVNfIYEACqpkCTXjJGA6jpPtusZRoDa96V0QzYrAzaDiSw5DFd+f7w60Gk8gHSfnjbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrezYJnvM1/iIaWoNsQoafkwOxiqOVh2njGea1GkqnWPuXY+YA
	4A8mXUzvpNVDPhVaB0ppRs+8pvsGEyGb8GTirxIHaQA0m2nghnZYYJ1FJg1rMq5HIbbSs6/ZbRP
	7w2+jGuOaJcrLNzi334Vfb2/bDo5VmoFUu32wgk+3mhfpycd+1m7yZf3f4Q==
X-Gm-Gg: ASbGnctc1lUTc7wYuVoH2Kf35wyNhLudwFHqZOXKVyr6e30hoY6wCrakCtLkD9DiryP
	cFTkE7jvMRXa5u1b963ac8zifSdAsPePeaIVedvkW07APiVKV5X3taOouRMaUsFDxc8e8kY4ukL
	0pQREbkPSbPZ7IWI0q5pLDBB+48SBQsItGnlaAMOwp4Ehyu+7A0nMZ0d0/5aB6SFMKTWBxWpLEN
	QxFpMWrlI/+yA8NzqKZU5Kc/ISJzhFSWkZ3MkvLklKJ8N2Y6kQbhxvVv6hi5tv8SJk/qWQb78cA
	Qz8NLa1Vp7M4sHo3nCAup+fmJfHoGXpFPs/dA0TYCC0kNh3DUWtpxlG3sYBm1c2cBqKDoyyiFQY
	wC1eiLs1k6uM=
X-Received: by 2002:a05:622a:552:b0:4af:4bac:e523 with SMTP id d75a77b69052e-4b2aaa2801dmr177903171cf.8.1756225032985;
        Tue, 26 Aug 2025 09:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9+dXXYCHz4z4s2jD0XCyJZAOQlENoCcuOTDMorPpnjSxVAev14M5eRLGZMcGQUodzjmRpVw==
X-Received: by 2002:a05:622a:552:b0:4af:4bac:e523 with SMTP id d75a77b69052e-4b2aaa2801dmr177902191cf.8.1756225032061;
        Tue, 26 Aug 2025 09:17:12 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8de632csm74458141cf.36.2025.08.26.09.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:17:11 -0700 (PDT)
Message-ID: <a2dec2d0-84be-4a4f-bfd4-b5f56219ac82@redhat.com>
Date: Tue, 26 Aug 2025 18:17:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 14/15] net: homa: create homa_plumbing.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250818205551.2082-1-ouster@cs.stanford.edu>
 <20250818205551.2082-15-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818205551.2082-15-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 10:55 PM, John Ousterhout wrote:
> +/* This variable contains the address of the statically-allocated struct homa
> + * used throughout Homa. This variable should almost never be used directly:
> + * it should be passed as a parameter to functions that need it. This
> + * variable is used only by a few functions called from Linux where there
> + * is no struct homa* available.
> + */
> +static struct homa *global_homa = &homa_data;

No need for this, use hame_data directly everywhere.

> +static struct proto homav6_prot = {
> +	.name		   = "HOMAv6",
> +	.owner		   = THIS_MODULE,
> +	.close		   = homa_close,
> +	.connect	   = ip6_datagram_connect,
> +	.ioctl		   = homa_ioctl,
> +	.init		   = homa_socket,
> +	.destroy	   = homa_sock_destroy,
> +	.setsockopt	   = homa_setsockopt,
> +	.getsockopt	   = homa_getsockopt,
> +	.sendmsg	   = homa_sendmsg,
> +	.recvmsg	   = homa_recvmsg,
> +	.hash		   = homa_hash,
> +	.unhash		   = homa_unhash,
> +	.obj_size	   = sizeof(struct homa_v6_sock),
> +	.ipv6_pinfo_offset = offsetof(struct homa_v6_sock, inet6),
> +
> +	.no_autobind       = 1,

Minor nit: no empty line above

> +};
> +
> +/* Top-level structure describing the Homa protocol. */
> +static struct inet_protosw homa_protosw = {
> +	.type              = SOCK_DGRAM,
> +	.protocol          = IPPROTO_HOMA,
> +	.prot              = &homa_prot,
> +	.ops               = &homa_proto_ops,
> +	.flags             = INET_PROTOSW_REUSE,
> +};
> +
> +static struct inet_protosw homav6_protosw = {
> +	.type              = SOCK_DGRAM,
> +	.protocol          = IPPROTO_HOMA,
> +	.prot              = &homav6_prot,
> +	.ops               = &homav6_proto_ops,
> +	.flags             = INET_PROTOSW_REUSE,
> +};
> +
> +/* This structure is used by IP to deliver incoming Homa packets to us. */
> +static struct net_protocol homa_protocol = {
> +	.handler =	homa_softirq,
> +	.err_handler =	homa_err_handler_v4,
> +	.no_policy =     1,
> +};
> +
> +static struct inet6_protocol homav6_protocol = {
> +	.handler =	homa_softirq,
> +	.err_handler =	homa_err_handler_v6,
> +	.flags =        INET6_PROTO_NOPOLICY | INET6_PROTO_FINAL,
> +};
> +
> +/* Sizes of the headers for each Homa packet type, in bytes. */
> +static u16 header_lengths[] = {
> +	sizeof(struct homa_data_hdr),
> +	0,
> +	sizeof(struct homa_resend_hdr),
> +	sizeof(struct homa_rpc_unknown_hdr),
> +	sizeof(struct homa_busy_hdr),
> +	0,
> +	0,
> +	sizeof(struct homa_need_ack_hdr),
> +	sizeof(struct homa_ack_hdr)
> +};
> +
> +/* Thread that runs timer code to detect lost packets and crashed peers. */
> +static struct task_struct *timer_kthread;
> +static DECLARE_COMPLETION(timer_thread_done);
> +
> +/* Used to wakeup timer_kthread at regular intervals. */
> +static struct hrtimer hrtimer;
> +
> +/* Nonzero is an indication to the timer thread that it should exit. */
> +static int timer_thread_exit;
> +
> +/**
> + * homa_load() - invoked when this module is loaded into the Linux kernel
> + * Return: 0 on success, otherwise a negative errno.
> + */
> +int __init homa_load(void)
> +{
> +	struct homa *homa = global_homa;
> +	bool init_protocol6 = false;
> +	bool init_protosw6 = false;
> +	bool init_protocol = false;
> +	bool init_protosw = false;
> +	bool init_net_ops = false;
> +	bool init_proto6 = false;
> +	bool init_proto = false;
> +	bool init_homa = false;
> +	int status;
> +
> +	/* Compile-time validations that no packet header is longer
> +	 * than HOMA_MAX_HEADER.
> +	 */
> +	BUILD_BUG_ON(sizeof(struct homa_data_hdr) > HOMA_MAX_HEADER);
> +	BUILD_BUG_ON(sizeof(struct homa_resend_hdr) > HOMA_MAX_HEADER);
> +	BUILD_BUG_ON(sizeof(struct homa_rpc_unknown_hdr) > HOMA_MAX_HEADER);
> +	BUILD_BUG_ON(sizeof(struct homa_busy_hdr) > HOMA_MAX_HEADER);
> +	BUILD_BUG_ON(sizeof(struct homa_need_ack_hdr) > HOMA_MAX_HEADER);
> +	BUILD_BUG_ON(sizeof(struct homa_ack_hdr) > HOMA_MAX_HEADER);
> +
> +	/* Extra constraints on data packets:
> +	 * - Ensure minimum header length so Homa doesn't have to worry about
> +	 *   padding data packets.
> +	 * - Make sure data packet headers are a multiple of 4 bytes (needed
> +	 *   for TCP/TSO compatibility).
> +	 */
> +	BUILD_BUG_ON(sizeof(struct homa_data_hdr) < HOMA_MIN_PKT_LENGTH);
> +	BUILD_BUG_ON((sizeof(struct homa_data_hdr) -
> +		      sizeof(struct homa_seg_hdr)) & 0x3);
> +
> +	/* Detect size changes in uAPI structs. */
> +	BUILD_BUG_ON(sizeof(struct homa_sendmsg_args) != 24);
> +	BUILD_BUG_ON(sizeof(struct homa_recvmsg_args) != 88);
> +
> +	pr_err("Homa module loading\n");

Please use pr_notice() instead.

> +	status = proto_register(&homa_prot, 1);
> +	if (status != 0) {
> +		pr_err("proto_register failed for homa_prot: %d\n", status);
> +		goto error;
> +	}
> +	init_proto = true;

The standard way of handling the error paths it to avoid local flags and
use different goto labels.

> +
> +	status = proto_register(&homav6_prot, 1);
> +	if (status != 0) {
> +		pr_err("proto_register failed for homav6_prot: %d\n", status);
> +		goto error;
> +	}
> +	init_proto6 = true;
> +
> +	inet_register_protosw(&homa_protosw);
> +	init_protosw = true;
> +
> +	status = inet6_register_protosw(&homav6_protosw);
> +	if (status != 0) {
> +		pr_err("inet6_register_protosw failed in %s: %d\n", __func__,
> +		       status);
> +		goto error;
> +	}
> +	init_protosw6 = true;
> +
> +	status = inet_add_protocol(&homa_protocol, IPPROTO_HOMA);
> +	if (status != 0) {
> +		pr_err("inet_add_protocol failed in %s: %d\n", __func__,
> +		       status);
> +		goto error;
> +	}
> +	init_protocol = true;
> +
> +	status = inet6_add_protocol(&homav6_protocol, IPPROTO_HOMA);
> +	if (status != 0) {
> +		pr_err("inet6_add_protocol failed in %s: %d\n",  __func__,
> +		       status);
> +		goto error;
> +	}
> +	init_protocol6 = true;
> +
> +	status = homa_init(homa);
> +	if (status)
> +		goto error;
> +	init_homa = true;

home_init() should be likely the first call in this function

> +
> +	status = register_pernet_subsys(&homa_net_ops);
> +	if (status != 0) {
> +		pr_err("Homa got error from register_pernet_subsys: %d\n",
> +		       status);
> +		goto error;
> +	}
> +	init_net_ops = true;
> +
> +	timer_kthread = kthread_run(homa_timer_main, homa, "homa_timer");
> +	if (IS_ERR(timer_kthread)) {
> +		status = PTR_ERR(timer_kthread);
> +		pr_err("couldn't create Homa timer thread: error %d\n",
> +		       status);
> +		timer_kthread = NULL;
> +		goto error;
> +	}
> +
> +	return 0;
> +
> +error:
> +	if (timer_kthread) {
> +		timer_thread_exit = 1;
> +		wake_up_process(timer_kthread);
> +		wait_for_completion(&timer_thread_done);
> +	}
> +	if (init_net_ops)
> +		unregister_pernet_subsys(&homa_net_ops);
> +	if (init_homa)
> +		homa_destroy(homa);
> +	if (init_protocol)
> +		inet_del_protocol(&homa_protocol, IPPROTO_HOMA);
> +	if (init_protocol6)
> +		inet6_del_protocol(&homav6_protocol, IPPROTO_HOMA);
> +	if (init_protosw)
> +		inet_unregister_protosw(&homa_protosw);
> +	if (init_protosw6)
> +		inet6_unregister_protosw(&homav6_protosw);
> +	if (init_proto)
> +		proto_unregister(&homa_prot);
> +	if (init_proto6)
> +		proto_unregister(&homav6_prot);
> +	return status;
> +}
> +
> +/**
> + * homa_unload() - invoked when this module is unloaded from the Linux kernel.
> + */
> +void __exit homa_unload(void)
> +{
> +	struct homa *homa = global_homa;
> +
> +	pr_notice("Homa module unloading\n");
> +
> +	unregister_pernet_subsys(&homa_net_ops);
> +	homa_destroy(homa);

home_destroy() should likely be the last call of this function.

> +/**
> + * homa_softirq() - This function is invoked at SoftIRQ level to handle
> + * incoming packets.
> + * @skb:   The incoming packet.
> + * Return: Always 0
> + */
> +int homa_softirq(struct sk_buff *skb)
> +{
> +	struct sk_buff *packets, *other_pkts, *next;
> +	struct sk_buff **prev_link, **other_link;
> +	struct homa_common_hdr *h;
> +	int header_offset;
> +
> +	/* skb may actually contain many distinct packets, linked through
> +	 * skb_shinfo(skb)->frag_list by the Homa GRO mechanism. Make a
> +	 * pass through the list to process all of the short packets,
> +	 * leaving the longer packets in the list. Also, perform various
> +	 * prep/cleanup/error checking functions.

It's hard to tell without the GRO/GSO code handy, but I guess the
implementation here could be simplified invoking __skb_gso_segment()...

> +	 */
> +	skb->next = skb_shinfo(skb)->frag_list;
> +	skb_shinfo(skb)->frag_list = NULL;
> +	packets = skb;
> +	prev_link = &packets;
> +	for (skb = packets; skb; skb = next) {
> +		next = skb->next;
> +
> +		/* Make the header available at skb->data, even if the packet
> +		 * is fragmented. One complication: it's possible that the IP
> +		 * header hasn't yet been removed (this happens for GRO packets
> +		 * on the frag_list, since they aren't handled explicitly by IP.

... at very least it will avoif this complication and will simplify the
list handling.

> +		 */
> +		if (!homa_make_header_avl(skb))
> +			goto discard;

It looks like the above is too aggressive, i.e. pskb_may_pull() may fail
for a correctly formatted homa_ack_hdr - or any other packet with hdr
size < HOMA_MAX_HEADER

> +		header_offset = skb_transport_header(skb) - skb->data;
> +		if (header_offset)
> +			__skb_pull(skb, header_offset);
> +
> +		/* Reject packets that are too short or have bogus types. */
> +		h = (struct homa_common_hdr *)skb->data;
> +		if (unlikely(skb->len < sizeof(struct homa_common_hdr) ||
> +			     h->type < DATA || h->type > MAX_OP ||
> +			     skb->len < header_lengths[h->type - DATA]))
> +			goto discard;
> +
> +		/* Process the packet now if it is a control packet or
> +		 * if it contains an entire short message.
> +		 */
> +		if (h->type != DATA || ntohl(((struct homa_data_hdr *)h)
> +				->message_length) < 1400) {

I could not fined where `message_length` is validated. AFAICS
data_hdr->message_length could be > skb->len.

Also I don't see how the condition checked above ensures that the pkt
contains the whole message.

/P


