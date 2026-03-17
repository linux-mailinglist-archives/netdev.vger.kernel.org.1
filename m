Return-Path: <netdev+bounces-268376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMD0Cf2suGkdhgEAu9opvQ
	(envelope-from <netdev+bounces-268376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:23:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 765652A285E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AD513031E9C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0203A242D89;
	Tue, 17 Mar 2026 01:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmVUjtfE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54F22D792
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773710551; cv=pass; b=Rji6nCSrGN+uFnZnk/+D4uXnbNrsPJHUQ8Lmz5kK/p7rMo7/uB9UeqtuqiMSJMWXvsD6ACtAjzSGpQm3xOgML28ft6rITPLxXnBQkfYdEJW2U7F0BeHYVKKI+j85HSzW5ulmKgjHPbPjZgTucVeRkTNMSP0hwect3aLVB22qPTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773710551; c=relaxed/simple;
	bh=dp6tMf9bDPCfIhp9l2aUppF7k+teSwvL9NaWQfUfRcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gG0sV1aOr2OaPaGdn7+keHjKTE3GLMyazZBUdQc4LxUSqVjrDcKTGQiNzqcckemiPwlR4fZ0pRDr31be7nNsnDo3oB864oMKp9KuYf+GtH0vbl6tM+7TdYZorsXK6mqregw9KVlMQv9e8F7Oz1i1+pTlHnuGo5AWg0ffhb47MME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmVUjtfE; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5860688eec.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 18:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773710549; cv=none;
        d=google.com; s=arc-20240605;
        b=JHu6/XGLu/mCm9HjvohcSg42Kdqcb/Wh8WCDpZ6z1+41QA3yPeOFMPLoBDHguwURXs
         wn2gQxPZLx+hfCV9FbwsnC9liGAasF8vlQaqihNag/JToSKZxX8xgQISD8MxpbP+QCxH
         92gVVJq/Z3uS7Cniu6KMlo29Jo/+fG2UN4SccV2T7fLEgKzv6quhaABwS9g4kUtUh7sj
         RbO8xQnPfAOy69Ha/xvaCLAFvMVxvyEp/E68kOAaum+8PfG3gYLX2S1DSCHI3vrMQJag
         rLPi8jnwXZCA9aYzIiXN9R6K7kks29VHKAZGmmo5wxm4qO9qcckzmcDshbljZB6lHK3W
         It7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dp6tMf9bDPCfIhp9l2aUppF7k+teSwvL9NaWQfUfRcs=;
        fh=Jvi6AUk2Y8ZGx1whXqpZoY+fLAuDErV/oMfoLLhkymc=;
        b=OSK0Z/SdpK1cTIgy8OpxZG7lBGmPHHm18UFetqKKBwPACem1gSlOmTSOUch013ehmP
         012/g5FHsm4nWkljz7XcCyPTMzq0Dlu8APaZ/58DtptVLwytaZpw5tI7Yc1iew/7/q9k
         +CXVuPpRNnmD8Y3tLMDML8AAPRnbsS5En7xKxJiP5MY1p+xJ85NNMlZEcBEtu82RvdDb
         sz/dmvVjs0clEbYOITLEWi+CWjMKW8nqSRZ1+XTsKjlkJL8S8ovyxNwrOqxPCqDzBJDB
         18mKTOVLh4fQ8vzUL/niK1KjHrCqo7E+RdR5JxrF+5kCiNqu1bqjC4hPDpl1/YG7Qdm+
         3/5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773710549; x=1774315349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp6tMf9bDPCfIhp9l2aUppF7k+teSwvL9NaWQfUfRcs=;
        b=gmVUjtfEwGzK7O2Hfo4Zl++8LWLn5Mc4o8sg2b1SpglAG82l1ALu6ZnNzJpCQ27Mv0
         z9i9S94Z6oEF8JieGybkSgkx/tJJDZAnXbXg1PZfBCODHEYeLvphUCoZt3jRleexdNhq
         hJr1Ch0KjA3vhakSWSgGeKZuF/Jx/s2b482SRXnjpQsdNDiN9OjMGBWdw4uWFOlCmyvJ
         yIZ5fH/voL3tBYeZ/G2bLfJjCGxIE7FmKh18U4799lum07A+83epcgnE8G0yPDDdrWbl
         +C997jMbLyPgUzJKTpCy/+/aWapdMfv9MxokZuDW/97XOUezQV5sn4vnP+eR33XOCiIE
         toxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773710549; x=1774315349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dp6tMf9bDPCfIhp9l2aUppF7k+teSwvL9NaWQfUfRcs=;
        b=hKoXOwPaT7Wjp1fjN9ihGJWRFKJpbPrhT8ks3l2BNRuoaFJTMzzB2mtDpqpcjX2E/M
         nOB3McU/3vgN8XEmqUQH+fKm2zyrPSj2QP/Ow2BmZzmxYRVH3vPJRMHeTESwWdWQ2rID
         wKlRiYUXnLmIpZYzan9JWshPKS1xYPiLfaoiGHljmBoi2Kk/Y9ALmILzYGFPTI+L3rdN
         IdHFwiNIzIpjGasGi3ucdj+HYJMQiI8Ve0lipAc6UpdfYR3vfAfNIFwJEbLDtck1jd2f
         qIs2BZBfWuGn1kzs9pFVnFnzbgFYVuHTcJTkLyj3uObTc7fxc2CCKY6Y0eMWAgLE5yFx
         9doQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+vx3DkxUvI+4S0jKqc2X80oAPDtQyyp8mguhv/+bU5lNaprB+x82V6gyrPKRiNMRCG+QqNfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykRFePVydaXl0NR6ghtOPhlk3KGzkWLkQSALzNNYZHpUJvaDGr
	xxOUP+SODUR6u++dcuKGvPowAG0DhYb+cgrpMXi0JKs0P2ez8rUB6U4W8L9gsIfElzMa6F1zSkZ
	M1dPm5bJjLvp7N16aNTU8uF63IFHG/WM=
X-Gm-Gg: ATEYQzy1nbVwzHTWuKCcWYBUO0I0ykHtVtaW64OBI6X8VLMY4MGVZ/6h7qfFIKlRPQ9
	QdQndaxvNqTopJTZBtf2aZ847wOk5GafHQ6NGILKYoGOQJkl3xPXQdu81Xt8+V7pJl6edzpX0mI
	hO5pCR/xdMZ9xuypMa8ZEpHWjcHI3WW0vtRqp21pjyeS3QKmFTdKTaBWS3krJX9SsxbndMQHFQt
	f7Pv/E7GOeyLvbwTSosNh6uMh0L1OmDlWaKussFdWZGilexTFlYeTKPTU2le2aeE6uPzOu9pftm
	IKe1iD8=
X-Received: by 2002:a05:7301:1695:b0:2c0:d04c:a6a6 with SMTP id
 5a478bee46e88-2c0d04cad22mr1390815eec.6.1773710548997; Mon, 16 Mar 2026
 18:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 17 Mar 2026 09:21:43 +0800
X-Gm-Features: AaiRm52DH5oXYk28FV_vIJOaFFEWo_W567s_FD9sQhe7xRrBOElIspH24hS3Uhw
Message-ID: <CAL+tcoDHaWXH-cN8hSAs6S_U7xfD5k+OdoAfKmYGeLaGGJLnYg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx processing
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268376-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com,iogearbox.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 765652A285E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 10:14=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Commit f620af11c27b ("xsk: avoid double checking against rx queue being
> full") addressed a case in copy mode, when working with multi-buffer
> xdp_buff, where we were peeking onto XSK Rx queue twice, to find out if
> there is a space to produce descriptors.
>
> Adjust ZC path to follow the same principle.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

