Return-Path: <netdev+bounces-284411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIhzGdjx+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:34:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A9D4CE972
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F5BD301997A
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EA2429838;
	Tue,  5 May 2026 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/rQKfw4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSbAZWNK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93E426ED2
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987514; cv=none; b=uu+6aTuprrENodbfLYVRf9oVKdsPlo4on1VZfLhlvLEaIRrp6hLV/rHPN42Pxfnj6b8EBeEWTZAbg7s+HeUglRReXoG5a4xuxijCALUrEWmPZ/0V+GPUmeKzXVDC3jAFlnkL14B+L+68mUVu21cwi6+4/M/Iv+FSQYTLs20yRUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987514; c=relaxed/simple;
	bh=jjZLXZ3VotsREl0DsXpKQ2oakkN57MTZvYPzwH0Ls2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVesiooPvMk3uYIxUCdiTUsxu41Exp3A7PK7fCl2NA1rIbsHKqcOFXCsUjmXGYl0lHBcivG2ZVRDD/2synVfRpGVCj8k/gZ6NnJKfigKbwuLCEiybQLHe2XFAAuFDDOTRnt3OesrtN+BpOhppeJyhG6CX13+suGxKIQxNX6clrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/rQKfw4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSbAZWNK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777987510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NP4rX7b9FZY0fbLuEXjv0M/HU/D303qx0QGgZMGR6PY=;
	b=F/rQKfw44ND0UxQx4zU36JjWTX2WGK54KXd4A4bqIp5FoffPtt3lW0Eaq25SnZCCTEBb7N
	7a++H+y3H30vR+/cjFPmXQ87O/L4HnRM/kZvERp8pM1s+cFeeY2Xs1YouNz8WXcL7fvjqE
	TrGxeY3UaSvyY+isg+TxUhTlfmHfSw0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-E8h082_QPmSv7VFllYAwRA-1; Tue, 05 May 2026 09:25:09 -0400
X-MC-Unique: E8h082_QPmSv7VFllYAwRA-1
X-Mimecast-MFC-AGG-ID: E8h082_QPmSv7VFllYAwRA_1777987508
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a5952c635so56514735e9.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 06:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777987508; x=1778592308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NP4rX7b9FZY0fbLuEXjv0M/HU/D303qx0QGgZMGR6PY=;
        b=RSbAZWNKOBtk1YZfL2WtNVTZ5LEzuj/UPWoewmvx11gZ+L+IvudxwavgNIgnsFPgf4
         lLFoJeDtBic3Qy81NlU3/mVEEYrsM+RfcPF1tUUWgW0HdMyVspLdQWGDpPu0/CtJFHr3
         h7V0jgDr8uhOxwKrgxatkId2EKz5eMmshuH1NDFcZD+p63i1gLydhdbzjQtVlKkpc5dS
         RO2aShSCW/ANHQtIecEmGo2NFFCRI0S7WaT/1jhGQNFEfDO6OopMrzvl7a+52tQY+iyO
         cqzaz09TbTcAzvFkIgoEayXeBMZCBj4GW3Nt87sF0cS+6Xi9trzBOsjDd7abXp5OpERa
         bp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777987508; x=1778592308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NP4rX7b9FZY0fbLuEXjv0M/HU/D303qx0QGgZMGR6PY=;
        b=J0VEvaBVGbV3gKg0Nl/hs45I6freeL3iopYfKS20Fr6d9LnbCrhR+wkGr47g71jOp3
         RqSh9nOeJuLPzFb1iXF1Kqvf9i7uhduhpYp5LOorI5pQ/rJLYuS7MeQu6EWwcdat+ANU
         5WkzIy/T/6mOIqC1XyJLRAjuS0fvBSsMqFIZVSRCiYhGBvWVVNT8JoaSw9SGxRrC3kBy
         guAdaBEVk8B4IC7pXoiHyckaehnyfOV2dEjLiTUnHrLR5GldHEcwR/iQrmB5lCUHFeo0
         Ur/8Yp7nBguIBqo/nZqbDrYkJSRk2neMGVG3t/R6yYP/lI1E9dEZXtFxSc3vIw7xZ7ed
         dLGw==
X-Forwarded-Encrypted: i=1; AFNElJ/ggUJJIW7TeeTLzm/rrNXaGgDFcgPWDD0Z0X/04FFUjd8v7jHlvO152KIW3h68UxYx3CLv8Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCpws18nTe0biw73HxM1Ewgx9ou8kVXAw636CiRZ7vBL+YDbgl
	MeJ+OHQvcXq0jwV9D+84FmevL8oJBP2+j44gRb+bR/Cb74690ddO2O970ZIGjF/LzwCU/uNqupK
	cs1gX7E5tW/xk75mI57Xkq6Cru9k4TDYx4glyNIYbJdPPF36BfAYfuH83MQ==
X-Gm-Gg: AeBDieuuMzlc4D0te7XXNgquUZpYOIgsEMiejHMdUtPcU6xnnDrLwfMV+BGFpprxmeU
	1VvWyDtwDkvh0oe15TDrM81eReGdvPrISr0we8esw1MYD91onkrLYkn1RJTj1BteYx/ilLfNEnA
	Bb/lpSSaa+nvkbpnpN2WAMFVcL2bJCkN66buBijCOD318psTPLJfNvp9yr6tOZahiK+URslgfdn
	9feAigyKE2DM8+LXNhtaLC2CzxVT5vqUM8x56Z38S8e/wzlH1RzKCCgz8JDkqdv/WvDGEMtk65t
	OBmpOHQuEiMcF4rlbBCu8c0BCGLdlDl9QMhgAd5Unuq4gLDqn9Vn7p/8IAbIZBBkQJVPl1TSX98
	zoKAEK8zyv8DaWJodGt9YqGw+J3veixiy6uev4ZSftv7P4kfERylRIDr5KbjeuIvF25I=
X-Received: by 2002:a05:600c:4f47:b0:488:b8bc:6a32 with SMTP id 5b1f17b1804b1-48a988be27dmr259135655e9.23.1777987507829;
        Tue, 05 May 2026 06:25:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4f47:b0:488:b8bc:6a32 with SMTP id 5b1f17b1804b1-48a988be27dmr259134965e9.23.1777987507268;
        Tue, 05 May 2026 06:25:07 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82308d77sm464849375e9.14.2026.05.05.06.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 06:25:06 -0700 (PDT)
Message-ID: <0f5da49c-7ed6-4547-9f89-bb3c3d62c3c3@redhat.com>
Date: Tue, 5 May 2026 15:25:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] selftests: openvswitch: add tests for tunnel
 vport refcounting
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Yuan Tan <tanyuan98@outlook.com>,
 Yang Yang <n05ec@lzu.edu.cn>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260430233848.440994-1-i.maximets@ovn.org>
 <20260430233848.440994-3-i.maximets@ovn.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260430233848.440994-3-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 73A9D4CE972
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284411-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 5/1/26 1:38 AM, Ilya Maximets wrote:
> @@ -830,6 +831,42 @@ test_tunnel_metadata() {
>  	return 0
>  }
>  
> +test_tunnel_refcount() {
> +	sbxname="test_tunnel_refcount"
> +	sbx_add "${sbxname}" || return 1
> +
> +	ovs_sbx "${sbxname}" ip netns add trefns || return 1
> +	on_exit "ovs_sbx ${sbxname} ip netns del trefns"
> +
> +	for tun_type in gre vxlan geneve; do
> +		info "testing ${tun_type} tunnel vport refcount"
> +
> +		ovs_sbx "${sbxname}" ip netns exec trefns \
> +			python3 $ovs_base/ovs-dpctl.py \
> +			add-dp dp-${tun_type} || return 1
> +
> +		ovs_sbx "${sbxname}" ip netns exec trefns \
> +			python3 $ovs_base/ovs-dpctl.py \
> +			add-if --no-lwt -t ${tun_type} \
> +			dp-${tun_type} ovs-${tun_type}0 || return 1
> +
> +		ovs_wait ip -netns trefns link show \
> +			ovs-${tun_type}0 >/dev/null 2>&1 || return 1
> +
> +		info "deleting dp - may hang if reference counting is broken"
> +		ovs_sbx "${sbxname}" ip netns exec trefns \
> +			python3 $ovs_base/ovs-dpctl.py \
> +			del-dp dp-${tun_type} &
> +
> +		dev_removed() {
> +			! ip -netns trefns link show "$1" >/dev/null 2>&1
> +		}
> +		ovs_wait dev_removed dp-${tun_type} || return 1
> +		ovs_wait dev_removed ovs-${tun_type}0 || return 1

FTR, here sashiko laments that if the reference counting is broken and
the del-dp process hangs, this could leave the background del-dp python
process running indefinitely.

I guess that if reference counting is broken inside the kernel, very
likely an host/VM reboot is needed, and the above does not matter.

/P


