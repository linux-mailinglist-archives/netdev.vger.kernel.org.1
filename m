Return-Path: <netdev+bounces-259347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN/oMLkFlmm4YQIAu9opvQ
	(envelope-from <netdev+bounces-259347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:32:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14406158BBB
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A676D300696E
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1F33321A1;
	Wed, 18 Feb 2026 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="kjtZR2JD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943D831ED64
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439521; cv=none; b=BOtUPoKe3DsxYlaryfgwj61k23Wg9khkglvKrFkYclbHR6H8qBXTLWblmPVgnGOLPi5R1v6tunJhu9bGTFQCsndqd6nb7dNFs+ncOxgLZ/dW5xE0uGPHxLljdAHgWs1GKHHnKzOSFBp/IvU2rX23w2E5wF2NoJQ9ubNYHcTizRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439521; c=relaxed/simple;
	bh=2EHUA0fanuBS81BjEWu273ZFRWW8IbSSVv9bDpRJrKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P43i/xu/acgI2UcD074Hp2IZuP4MGjZbhTCCa803U6jRAhtVPfID5qp3fKqT4x2xYuDDt6st2l6a30aZhNk2oVYf00bYSUgriewKTSDfyBcgD4WOvCNW6EIXja6NKS4IgE1Govzo3uCMFyLCihlikceiEyyYU8ow55Wwz8ep6OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=kjtZR2JD; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5069df1d711so355941cf.2
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 10:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771439518; x=1772044318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXSRRpfr9jF/KBDZrI0ZvqAcSJszJWLY93yov92tiK0=;
        b=kjtZR2JDSj5hYACS7H7TvGEBNf53NoHcOmwgVa3hR6jwDfmWj+td3xmw2DKA4HCUHy
         0LQ/Q2drXzXlrhxgpKbNZsVK+IXzuZols1dF8f0j3Bn25fuhhvhYd+nS8K6c58zdpxoH
         AYqIyg9MyUdpIBeKEw/QjfcCC7mcPq5Mv1QqV79w0A7WXRRHOF+Jo6f6LSGUGgUDkkrh
         4qUqf3VTSqzd1gBq+jKkrEIerpPVZ2KKVArAIRsTFDAz3TYIbpg3HP9PMh7IMRWsLnAB
         CjlC8CGETyL7A7jw0gbywWzJUceU7jmuDtu6Ohf1ZH908aJd/2hQAVCiJ1qnDhbY4lJP
         NY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439518; x=1772044318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DXSRRpfr9jF/KBDZrI0ZvqAcSJszJWLY93yov92tiK0=;
        b=kiJ+C2Cj76uOGoDAbN2ifRhV9EhjsjbHu7hCwMYwc8jeGth3N0H1LA+nHUZryFbxTA
         1nWpkqcIGUFXxkgxpheasJz/kkKRos4GTHy0LwF7HidHShGxhI9VLVb7NDxFRA7mkqoc
         qnKtmhIYMtJWpmIFoQI0LgaI6+ny1CuUYPXqERqy0DajAOiRZGAN4/aVuLi4VjmHhmcr
         otyfDo8X2Q6MNKm6SfUTqLKfT1+esnBa3PkDXPLZ7FyORXcF12NqCckF7ZB/V2UEy121
         i827zXJc7mtlkkJuBvgKYRWkIDGc0bZIoQfezHwDobC6/qBIZHryVHFZKGmH2weUhgJO
         pESw==
X-Forwarded-Encrypted: i=1; AJvYcCXK6VNg1H9mdTXKdo0PbHZaZbX/KCT6Fm+uEBx1ouPAovu5kR2B203U2S4Qfo6Nlf+X7CGZhyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHmhU90cdSCbVHQhNHkbKI90bhnbmmuYIvFTKbcJruRkJQrCQZ
	M1s9u8JthjtU+qkPJiZyJytSz6uBbIKL4OpfePnsnqK6+mgvOoOT0F69mIkf+9qc9x0=
X-Gm-Gg: AZuq6aKWj64qgMLHLQzcmOwgBd0gdO0fY7D0kLTsDWdDs6ixC/Ovw9g1iqyWUUoTDE/
	1FWfznaVXszMtAf3ClS9qlQyYZkAbj3q5UP0rv3xLJ/K/OF6UwF+jNIpsLL3HsxTvVTNUy2Aj+7
	2dFlV15gp7JmxyhNMIIa6u1+ZGoFSE7hc4k4VNP73eavKk/euGMyb0AZ6PYe2vxAC4SXrmY1+1P
	A0h7eDsAOX1czJgs5qNaVYgvm0A2WVJE2aqsdsrkSzVQaFJSJnxDUjoptnc+pNvvahnYuOwhDSC
	76mH6gAMd1az1z2CgG2ILukn1bspjz34VC+Rb9bqfFNlZssxYIspHSQqOj1aifno45U0/mOzUZ9
	GyOLVh3VB/AV8BzVdO+/bZPcvsvn3sjqEKa+t9ltFDNeqf3KPMAlLnLkZkBqZfdMEq7DetgEpv5
	aLUoCSE0Sc+lLqvM4eor8P5bqM7QeVLgStwL3TPrN6hbn31l8pNPeDP4DqrjWhl3Ni
X-Received: by 2002:ac8:7d8e:0:b0:4f1:c66d:4c98 with SMTP id d75a77b69052e-506a8294747mr241250731cf.24.1771439518454;
        Wed, 18 Feb 2026 10:31:58 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506849fbb9dsm202588841cf.15.2026.02.18.10.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:31:58 -0800 (PST)
Date: Wed, 18 Feb 2026 10:31:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2 1/2] mptcp: monitor: also show iface name
Message-ID: <20260218103155.486d20ee@phoenix.local>
In-Reply-To: <20260211-mptcp-color-v1-1-01832777611d@kernel.org>
References: <20260211-mptcp-color-v1-0-01832777611d@kernel.org>
	<20260211-mptcp-color-v1-1-01832777611d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-259347-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14406158BBB
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 13:03:17 +0100
"Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:

> @@ -530,7 +541,7 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
>  	if (tb[MPTCP_ATTR_TIMEOUT])
>  		printf(" timeout=%u", rta_getattr_u32(tb[MPTCP_ATTR_TIMEOUT]));
>  	if (tb[MPTCP_ATTR_IF_IDX])
> -		printf(" ifindex=%d", rta_getattr_s32(tb[MPTCP_ATTR_IF_IDX]));
> +		print_iface(rta_getattr_s32(tb[MPTCP_ATTR_IF_IDX]));
>  	if (tb[MPTCP_ATTR_RESET_REASON])
>  		printf(" reset_reason=%u", rta_getattr_u32(tb[MPTCP_ATTR_RESET_REASON]));
>  	if (tb[MPTCP_ATTR_RESET_FLAGS])


The whole monitor message output format here is divergent from what other
iproute2 commands do. If you look at ip monitor there are no '=' signs
in the output.

Please fix the whole function. Ideally all of iproute commands should
support JSON in monitor mode as well. But that is a bigger effort.



