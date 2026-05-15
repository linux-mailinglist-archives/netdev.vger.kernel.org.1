Return-Path: <netdev+bounces-288515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FaOA82pB2pSBQMAu9opvQ
	(envelope-from <netdev+bounces-288515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:18:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F0A55950B
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81F1A3004D2F
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482483612FB;
	Fri, 15 May 2026 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPkDR48S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99953F44D9
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887113; cv=none; b=cJlz/2f2q2WRZpTyHSyj0LMJG/UorJPE23g/NOJqfnrgpsZ803AJy6S1bh1arVa0zWMQKZ4JcV9DWbx6FvWWY3KbWhSFFOu73x+nTl0oCsTtag7TbVP16gb/Vv57zN7w+MJQkkkIAwHexlhjvlvmiVf4W1muJ32V7nhtw5c/RTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887113; c=relaxed/simple;
	bh=xkP52rrSn3t/3+BOiyGAJRY4IeSQN66ULs+HQ50ravA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pqy/Zt+eVrlY+V3wRK3+YNsO/M7Exak0U9zvbfKXTW7gt+bin1Qafnsu/bSMk/8cbZHgvWtm30vDNu/Hpume0bElb3vE5HazySi5alftHRGK2Ex0GIuwx7e+C9fVy5CNt5860W7C0FurrK8LSi5cs01zprYxBGP34jHJp4cCPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPkDR48S; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so1843885eec.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 16:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778887111; x=1779491911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jEEAYpfSRMrwhZU9K2WZtZZ778OfLljkr2HuZqWMK0M=;
        b=TPkDR48S0Bt5u2PuGXAIvFXm5JxiVkEoZL5H+LEchdeFO2nNLPydNRRkeY1hM8wmq3
         8Fh4v9vyP7suYVLnqiTKXK5w6zVJXWY6bvCbRA+zmYmujWhlLAMXvG3+KDzdlYMFDX04
         7Y9Jyb+k+Bg3jRREbFJu/nB+C/ylxbNLX/EtvqeoNXenHOghApDZYUfwgboXOxIcTPRT
         B79eF1Nn4NGNwXUqI2gnj41dwYuL2fNcBn7t6n2UPWZzhOKJA5QucLd+IlhVESflWLNp
         zRjHYY8obWr9pX7aEt0AQv2bbIZmVZNDwh6vBE200iq1oUov6OEHAyeFU5i7tsdIFiTp
         xBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778887111; x=1779491911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEEAYpfSRMrwhZU9K2WZtZZ778OfLljkr2HuZqWMK0M=;
        b=e+WsgfUXPx+7Cm+I/vS/N8U6CYAycipmMk/eGoO4br4ECxASFjRnnWc8h+xCmlPx9W
         bD2zNbyGweSVtwl2DMlkhLt2J3SQCusyHsY9WA7zdHbXBHYLXEFHJCzlGml+87fjh8Ln
         /jrMEE7LvX7S0ndd4uO/afO2IfEfl1a79vVkE7n00DcGR0IgAEOQ7pIDtHxNOVpeoVx1
         UYkaP4gls0iQaBZ7l/ysejO/DI9p9kqkG1zPy9CiDIfOYmbGkL8Vw8UG9KzT7F83XLe0
         oGFoJpfYoCp/CgOpPo5iNknwIIDD5AQ1flrBjnKu/ZAi8f3T/dGBwRu+QszHSdYKl97y
         XBRw==
X-Forwarded-Encrypted: i=1; AFNElJ8MA0BxODbQTdXHtR72cC/zkFpEt2e/qQsRmgeXosfRx6BnGk8aqclPmf7BvBTJ8MOf+LIw0Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/C3jy9WCEgvC9rAYpLEpYjwPOBoy3pSfnq/3JGfY3CShMKmZ
	05AcTi0rSC58BeV5sRNWTxe/Ugyqot7G+l1ywsD4d2SvIO/xBtQOyzQE
X-Gm-Gg: Acq92OGR4koskPpfrVHK8PaBjqQMP8ONp45sFpde9V6VYEI6kBt2+7kjhMUVm4sz1eB
	mNPPmPIFEKKw1B6K4azGNItzFxtLHMLDy63JQsw1Ut0JWrbkj3h0ff1DbDQgXCDYBkEOcMZoON+
	NgBhs5SL0sEU5nypdoLWVCH0IHkoTL2Ebc9oyj7vuE4GRDNZXK+EukxnucNtODLImVv2A1MRtEs
	Fg+TXb1k4r00nZVIDrkjac1V8kC3TkbqO9EHFhPmxhG4EfDJ2DNRakK2Q0mkrqxjvbduPZqicqm
	r8bFi3Gwou+jCmqNg5VY8rompE6ffnjCUk74BSAsDFBbpWaR0/7+hci5jjTCEqmQx7/gIY0bJtM
	u/XARiWDHXpE675qJyqhVr1vdt7b/7pnown9i4ngION7tahditiLf2iuiRC+FDJi1rzXZMGsmaN
	nRnl/VBEE22Vic3uIw51LEts+2ziwPACWPBnQP8wQFqBpgFFxvIsl3Yt9/85EK
X-Received: by 2002:a05:7300:72c9:b0:2f6:9cb5:6c27 with SMTP id 5a478bee46e88-3039867eec5mr3200852eec.21.1778887110735;
        Fri, 15 May 2026 16:18:30 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::141c? ([2620:10d:c090:400::5:3692])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978b3cb2sm10657453eec.30.2026.05.15.16.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 16:18:30 -0700 (PDT)
Message-ID: <ae1103c0-c407-4215-9ce0-5a775e781eb2@gmail.com>
Date: Sat, 16 May 2026 04:18:23 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v3 5/6] netshaper: Add group command for
 creating scheduling hierarchies
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, pabeni@redhat.com, kuba@kernel.org,
 ernis@linux.microsoft.com, alexanderduyck@gmail.com
References: <20260511183915.797792-1-mohsin.bashr@gmail.com>
 <20260511183915.797792-6-mohsin.bashr@gmail.com>
 <9866a42a-98e8-4a34-9962-33ec0df4dcc3@kernel.org>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <9866a42a-98e8-4a34-9962-33ec0df4dcc3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A1F0A55950B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288515-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[networkplumber.org,redhat.com,kernel.org,linux.microsoft.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 5/14/26 8:15 AM, David Ahern wrote:
> On 5/11/26 12:39 PM, Mohsin Bashir wrote:
>> @@ -319,6 +324,217 @@ static int do_cmd(int argc, char **argv, int cmd)
>>   	return err;
>>   }
>>   
>> +#define NET_SHAPER_MAX_LEAVES	256
> 
> why 256 as the limit? What drives a max value -- anything related to the
> uapi? Will 256 ever be deemed too little? if not, why?
> 

It is just an arbitrary value and there's no uapi basis for this. I can 
switch to dynamic allocation/re-allocation.

>> +
>> +static int do_group(int argc, char **argv)
>> +{
>> +	GENL_REQUEST(req, 4096, genl_family, 0, NET_SHAPER_FAMILY_VERSION,
>> +		     NET_SHAPER_CMD_GROUP, NLM_F_REQUEST | NLM_F_ACK);
>> +
>> +	struct shaper_args args = SHAPER_ARGS_INIT;
>> +	bool parsing_leaves = false, has_handle_id = false, has_parent_id = false;
>> +	int parent_scope = -1, num_leaves = 0;
>> +	int err, ret, handle_scope = NET_SHAPER_SCOPE_UNSPEC;
>> +	__u32 handle_id = 0, parent_id = 0;
>> +	struct nlmsghdr *answer;
>> +
>> +	struct {
>> +		int scope;
>> +		__u32 id;
>> +	} leaves[NET_SHAPER_MAX_LEAVES];
>> +
>> +	while (argc > 0) {
>> +		if (parsing_leaves) {
> 
> 
> This while loop is really long. Move this parsing_leaves code to a
> function and then drop the parsing_leaves flag.

Yeah, that's a good suggestion.

> 
>> +			if (strcmp(*argv, "scope") == 0) {
>> +				int lscope;
>> +
>> +				NEXT_ARG();
>> +				lscope = parse_scope(*argv);
>> +				if (lscope < 0) {
>> +					fprintf(stderr, "Invalid leaf scope \"%s\"\n",
>> +						*argv);
>> +					return -1;
>> +				}
>> +				NEXT_ARG();
>> +				if (strcmp(*argv, "id") != 0) {
>> +					fprintf(stderr, "Expected \"id\" after leaf scope\n");
>> +					return -1;
>> +				}
>> +
>> +				NEXT_ARG();
>> +				if (num_leaves >= ARRAY_SIZE(leaves)) {
>> +					fprintf(stderr, "Too many leaves\n");
>> +					return -1;
>> +				}
>> +				leaves[num_leaves].scope = lscope;
>> +				if (get_unsigned(&leaves[num_leaves].id, *argv, 10)) {
>> +					fprintf(stderr, "Invalid leaf id\n");
>> +					return -1;
>> +				}
>> +				num_leaves++;
>> +				argc--;
>> +				argv++;
>> +				continue;
>> +			}
>> +			parsing_leaves = false;
>> +		}
>> +
>> +		ret = parse_shaper_arg(*argv, &argc, &argv, &args);
>> +		if (ret < 0)
>> +			return -1;
>> +		if (ret > 0) {
>> +			argc--;
>> +			argv++;
>> +			continue;
>> +		}
>> +
>> +		if (strcmp(*argv, "handle") == 0) {
>> +			NEXT_ARG();
>> +			if (strcmp(*argv, "scope") != 0) {
>> +				fprintf(stderr, "Expected \"scope\" after \"handle\"\n");
>> +				return -1;
>> +			}
>> +			NEXT_ARG();
>> +			handle_scope = parse_scope(*argv);
>> +			if (handle_scope < 0) {
>> +				fprintf(stderr, "Invalid handle scope \"%s\"\n",
>> +					*argv);
>> +				return -1;
>> +			}
>> +			if (handle_scope != NET_SHAPER_SCOPE_NODE &&
>> +			    handle_scope != NET_SHAPER_SCOPE_NETDEV) {
>> +				fprintf(stderr, "Group handle scope must be \"node\" or \"netdev\"\n");
>> +				return -1;
>> +			}
>> +
>> +			if (argc > 1 && strcmp(argv[1], "id") == 0) {
>> +				NEXT_ARG();
>> +				NEXT_ARG();
>> +				if (get_unsigned(&handle_id, *argv, 10)) {
>> +					fprintf(stderr, "Invalid handle id\n");
>> +					return -1;
>> +				}
>> +				has_handle_id = true;
>> +			}
>> +		} else if (strcmp(*argv, "parent") == 0) {
>> +			NEXT_ARG();
>> +			if (strcmp(*argv, "scope") != 0) {
>> +				fprintf(stderr, "Expected \"scope\" after \"parent\"\n");
>> +				return -1;
>> +			}
>> +			NEXT_ARG();
>> +			parent_scope = parse_scope(*argv);
>> +			if (parent_scope < 0) {
>> +				fprintf(stderr, "Invalid parent scope \"%s\"\n",
>> +					*argv);
>> +				return -1;
>> +			}
>> +			if (parent_scope != NET_SHAPER_SCOPE_NODE &&
>> +			    parent_scope != NET_SHAPER_SCOPE_NETDEV) {
>> +				fprintf(stderr, "Parent scope must be \"node\" or \"netdev\"\n");
>> +				return -1;
>> +			}
>> +
>> +			if (parent_scope == NET_SHAPER_SCOPE_NODE) {
>> +				NEXT_ARG();
>> +				if (strcmp(*argv, "id") != 0) {
>> +					fprintf(stderr, "What is \"%s\"\n", *argv);
>> +					usage();
>> +					return -1;
>> +				}
>> +				NEXT_ARG();
>> +				if (get_unsigned(&parent_id, *argv, 10)) {
>> +					fprintf(stderr, "Invalid parent id\n");
>> +					return -1;
>> +				}
>> +				has_parent_id = true;
>> +			} else if (argc > 1 && strcmp(argv[1], "id") == 0) {
>> +				NEXT_ARG();
>> +				NEXT_ARG();
>> +				if (get_unsigned(&parent_id, *argv, 10)) {
>> +					fprintf(stderr, "Invalid parent id\n");
>> +					return -1;
>> +				}
>> +				has_parent_id = true;
>> +			}
>> +		} else if (strcmp(*argv, "leaves") == 0) {
>> +			parsing_leaves = true;
>> +			argc--;
>> +			argv++;
>> +			continue;
>> +		} else {
>> +			fprintf(stderr, "What is \"%s\"\n", *argv);
>> +			usage();
>> +			return -1;
>> +		}
>> +		argc--;
>> +		argv++;
>> +	}
>> +
>> +	if (args.ifindex == -1)
>> +		missarg("dev");
>> +	if (handle_scope == NET_SHAPER_SCOPE_UNSPEC)
>> +		missarg("handle");
>> +	if (parent_scope < 0)
>> +		missarg("parent");
>> +	if (num_leaves == 0)
>> +		missarg("leaves");
>> +
>> +	addattr32(&req.n, sizeof(req), NET_SHAPER_A_IFINDEX, args.ifindex);
>> +
>> +	struct rtattr *parent = addattr_nest(&req.n, sizeof(req),
>> +					     NET_SHAPER_A_PARENT | NLA_F_NESTED);
> 
> no inline declarations.
> 
> Claude and Codex like to do this. If this code was co-authored by an AI
> tool, please add the Assisted by tag (see
> Documentation/process/coding-assistants.rst in the kernel repo). And if
> that is true (code is co-authored by AI), drop the Reviewed-by tag.
> 
> 

Sure.

