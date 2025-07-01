Return-Path: <netdev+bounces-202895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B5DAEF95E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEB5443A7E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AADD2741CE;
	Tue,  1 Jul 2025 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpTKZY0l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B5321D5BC
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374569; cv=none; b=pctdvrnw7GoVzvz5KjxmWC3K921KGhrPzjmdwgKWQkUeOxFf4p0YSsVRdYh1FchcL55x/UF6Rm5YP/ONu17th5KDQHjNJ9F6VlsAwIjxdaEwihwmpzBSw1rohn5DTDbt3qNH653MKpMLE6lgWVnFXX7TFTrd/pV9BrPVYmKA2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374569; c=relaxed/simple;
	bh=TKG5IymVnkXJex1Gwu3CospUcoxQz3nNTflPsWghNUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDDOuwUtT7a4cal8o9e61e12anZztGMnTru64DHFhOwrrqB9mz1T/gdiwg7IqRyNj1DSnmkPQZ8Aa/qo+HiyBpmnoMXT53/0TWOTqJhXXzf6jSzDmsHpNpHB2TxTJPyWINleV0Kw1J6xmGt3aCH5QVwLjlY2MCz653HQ1q9ZUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpTKZY0l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751374566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBTTVjLLJBrVGUELHkLxjKRb9WdjU8gNsqCCuiEsmE4=;
	b=UpTKZY0lWq/di5n9flfildEPiDACfJxCz7AXgfORlUIra4Ni41EXN/jqltnP6aUWkXmOEl
	V+Skv/ulqxWiacWD06IZOWlfIYH7sgwM0qV/pNxaCeB+oznzxi9AMu9FD+5ixfcpJ7JjD9
	f3nud99PN3PNJeUWB5vhCeA2xGij0Lw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-_K4fz0QwMtqFGQomdJ5wVA-1; Tue, 01 Jul 2025 08:56:05 -0400
X-MC-Unique: _K4fz0QwMtqFGQomdJ5wVA-1
X-Mimecast-MFC-AGG-ID: _K4fz0QwMtqFGQomdJ5wVA_1751374564
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4538f375e86so29811935e9.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 05:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751374564; x=1751979364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBTTVjLLJBrVGUELHkLxjKRb9WdjU8gNsqCCuiEsmE4=;
        b=H1RWWDE41nabAxjQXSVa3fWfQ6PKL+/qAwXjLQkB9jPKA5/bDCEGPDGhA31gao8X+0
         GVTLSM3PPqEbvYBVXpb3c13C9XO4EzjyZtP9slLldQsfz2UaGd7u3aw1fmEae72TUnBQ
         avm4qnHM/ma5FD4tFTmMfLGWh2oevKo1fpO4rw+2Ws8aAeNkHdBty4oL36V+OsEeOYMm
         2DyxqXCda8yg22zWWqlrnkmJ9YgPIMPZKN2IBLThLPqE8TCjdLrhfQkmrH0HfCNK5p92
         LRjsL3rLgCtWNaAQsBbG8A4rBrh9jjlGBhDgSD26ndLPKdJxGRyOT0REqpgPep+yBUob
         kWVg==
X-Gm-Message-State: AOJu0YxsJ/iMsmLy2M3SVektj2HriC5w3fxb7LOd1bqWZ91qEgfxIhdk
	KmrzuWC+1bqks1SRc+QeO68TIlzFfR9KDlSyQcTQHWPZDdrxxj/8prV3NTL2WFWCPWfOHRY+tAq
	xFv1+fUBW4ZqoXZIUZ+A50Y0W/i/2lcFAp2P8xFsB3CrcVCJFFdIBH+PB8A==
X-Gm-Gg: ASbGncsDLv+wQb62ejFx2evpUxSBvSlBeBmu3BzuJJ8iA/8x1L8dWfWumhNN7ALqwn3
	eQtpitXWSM+fUEQuvcn86g6Kdu9kFcEyK8IhLkLeAYkSE90tBdLLTjWbSyAyexSJkOXZm6JqOrb
	pzT9/T1P5p2CBMD2MZCc9IoOWAyfB8KeM8hhLAL3s7Fk7XGtSkDqdbpcBWJ9pxBW/WhAsQX3z/D
	HzzTPv5otJdCDKFoF3ChVbd28/llg6VCcvyWlxmGY1D7HSK9aDfrLVETlO2uSVZ6DE/MdQ7F1vc
	cocYohFfsM9SIIFLhRQqkZVlSX1VOQzkkd8Rk8VxjNC6WqOYDbijyBAxZV783mjvLAUmGA==
X-Received: by 2002:a05:600c:4752:b0:453:a95:f07d with SMTP id 5b1f17b1804b1-4538ee27811mr225406175e9.10.1751374563662;
        Tue, 01 Jul 2025 05:56:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaw4kk4Kktx3Hecxbs6t1i/0jp4a/LW9tAythw2vOj1c39nlQ1UxxFJwKx+MpgP7+zm22KQw==
X-Received: by 2002:a05:600c:4752:b0:453:a95:f07d with SMTP id 5b1f17b1804b1-4538ee27811mr225405765e9.10.1751374563208;
        Tue, 01 Jul 2025 05:56:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247b:5810:4909:7796:7ec9:5af2? ([2a0d:3344:247b:5810:4909:7796:7ec9:5af2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e595c6sm13522571f8f.66.2025.07.01.05.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:56:02 -0700 (PDT)
Message-ID: <f875faa2-718d-4244-bb86-2178fed55922@redhat.com>
Date: Tue, 1 Jul 2025 14:56:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v06 4/8] hinic3: Command Queue interfaces
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>,
 Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman Ghosh
 <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1750937080.git.zhuyikai1@h-partners.com>
 <6c5406f1e4981a5c4eb3345199f480e37a5e7223.1750937080.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6c5406f1e4981a5c4eb3345199f480e37a5e7223.1750937080.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 8:12 AM, Fan Gong wrote:
> +static void cmdq_sync_cmd_handler(struct hinic3_cmdq *cmdq,
> +				  struct cmdq_wqe *wqe, u16 ci)
> +{
> +	spin_lock(&cmdq->cmdq_lock);
> +	cmdq_update_cmd_status(cmdq, ci, wqe);
> +	if (cmdq->cmd_infos[ci].cmpt_code) {
> +		*cmdq->cmd_infos[ci].cmpt_code = CMDQ_DIRECT_SYNC_CMPT_CODE;
> +		cmdq->cmd_infos[ci].cmpt_code = NULL;
> +	}
> +
> +	/* Ensure that completion code has been updated before updating done */
> +	smp_rmb();

There is something off with the above barrier. It's not clear where is
the paired wmb() and the comment looks misleading as this barrier order
reads operation and not writes (as implied by 'updating').

+static int cmdq_sync_cmd_direct_resp(struct hinic3_cmdq *cmdq, u8 mod,
u8 cmd,
> +				     struct hinic3_cmd_buf *buf_in,
> +				     u64 *out_param)
> +{
> +	struct hinic3_cmdq_cmd_info *cmd_info, saved_cmd_info;
> +	int cmpt_code = CMDQ_SEND_CMPT_CODE;
> +	struct cmdq_wqe *curr_wqe, wqe = {};
> +	struct hinic3_wq *wq = &cmdq->wq;
> +	u16 curr_prod_idx, next_prod_idx;
> +	struct completion done;
> +	u64 curr_msg_id;
> +	int errcode;
> +	u8 wrapped;
> +	int err;
> +
> +	spin_lock_bh(&cmdq->cmdq_lock);
> +	curr_wqe = cmdq_get_wqe(wq, &curr_prod_idx);
> +	if (!curr_wqe) {
> +		spin_unlock_bh(&cmdq->cmdq_lock);
> +		return -EBUSY;
> +	}
> +
> +	wrapped = cmdq->wrapped;
> +	next_prod_idx = curr_prod_idx + CMDQ_WQE_NUM_WQEBBS;
> +	if (next_prod_idx >= wq->q_depth) {
> +		cmdq->wrapped ^= 1;
> +		next_prod_idx -= wq->q_depth;
> +	}
> +
> +	cmd_info = &cmdq->cmd_infos[curr_prod_idx];
> +	init_completion(&done);
> +	refcount_inc(&buf_in->ref_cnt);
> +	cmd_info->cmd_type = HINIC3_CMD_TYPE_DIRECT_RESP;
> +	cmd_info->done = &done;
> +	cmd_info->errcode = &errcode;
> +	cmd_info->direct_resp = out_param;
> +	cmd_info->cmpt_code = &cmpt_code;
> +	cmd_info->buf_in = buf_in;
> +	saved_cmd_info = *cmd_info;
> +	cmdq_set_lcmd_wqe(&wqe, CMDQ_CMD_DIRECT_RESP, buf_in, NULL,
> +			  wrapped, mod, cmd, curr_prod_idx);
> +
> +	cmdq_wqe_fill(curr_wqe, &wqe);
> +	(cmd_info->cmdq_msg_id)++;
> +	curr_msg_id = cmd_info->cmdq_msg_id;
> +	cmdq_set_db(cmdq, HINIC3_CMDQ_SYNC, next_prod_idx);
> +	spin_unlock_bh(&cmdq->cmdq_lock);
> +
> +	err = wait_cmdq_sync_cmd_completion(cmdq, cmd_info, &saved_cmd_info,
> +					    curr_msg_id, curr_prod_idx,
> +					    curr_wqe, CMDQ_CMD_TIMEOUT);
> +	if (err) {
> +		dev_err(cmdq->hwdev->dev,
> +			"Cmdq sync command timeout, mod: %u, cmd: %u, prod idx: 0x%x\n",
> +			mod, cmd, curr_prod_idx);
> +		err = -ETIMEDOUT;
> +	}
> +
> +	if (cmpt_code == CMDQ_FORCE_STOP_CMPT_CODE) {
> +		dev_dbg(cmdq->hwdev->dev,
> +			"Force stop cmdq cmd, mod: %u, cmd: %u\n", mod, cmd);
> +		err = -EAGAIN;
> +	}
> +
> +	smp_rmb(); /* read error code after completion */

Isn't the errcode updated under the spinlock protection? Why is this
barrier neeed?

/P


