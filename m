Return-Path: <netdev+bounces-151975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 800329F21B8
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 03:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0218165C58
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 02:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF0E4C9A;
	Sun, 15 Dec 2024 02:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcJxSkWK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1D14689;
	Sun, 15 Dec 2024 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734229067; cv=none; b=jRIU9bgmWHvKrLVHQ9Ti65/LMQTU/qlfG1038yZ2/k1takhQCnJsG/DgYNAboU42OBaOHc/fFYpipVTbSQe8XQLsp6J7zZu3pfjiS1qVtu6stus+tTm7U5xJ87Vh1vWJw4jDiiM6MZqaVxgpB8fZQjPNcsDN6sjQHO69FPwbYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734229067; c=relaxed/simple;
	bh=1jXBw1XPkbs+3PW+Ku0V9cmcLDYFHxIln8uavLe/auw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bi2zOMUZ09Tgl6v7hQ95J2TeADxDF9ScIvXSnIpdZ3YEdRPHbrKtgBikpOLoUdONX0FPDRlKMLQ40asjErUV9vL6KrGkaSV7sh2WR6wTLtxDYfXFYnHpX+NlZE8AbAWWLdXAFrQ/XWtGD/xtK5SQdv0Zu3Z3l8Hbg0gxB6oQfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcJxSkWK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385e0e224cbso1559861f8f.2;
        Sat, 14 Dec 2024 18:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734229064; x=1734833864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6knxOhrq01m9fcLE+SYB9TQecvDtnka5bQk5EmhLzdU=;
        b=kcJxSkWKOzKtwG4usj/Mdr3RlAlTSrauDCU7jhxEmkWArj82g2m+NDQpcfszJYxiIO
         9nIOPOoUw8FidLrZRdgCggjlX02B3Wb7PUa67A9+azQeTAmtOoJwFISnxjA2Yau0KepG
         N2hb18LxNExkEwnyjQEgUyDEs8E0g4O/Uw83A12gaPIrEtKcO/RAfs4rFcaop7F/791L
         s/1gOhIw8Q7Ni0b3MhJ1SdSCyHoKEL0aipHgi4DcvKc4BtrO0xO0xiJ/QMNmFrmkIec4
         yO9LlGEzyVJwE4s369Djvp5PtczrYVKastkwRSGimP5D+SFnmBgM7cAI2efpd5hAHhnz
         cB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734229064; x=1734833864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6knxOhrq01m9fcLE+SYB9TQecvDtnka5bQk5EmhLzdU=;
        b=En5Dex+uZhBM60054FjK9D38dW/KpKqnh1FelfDIxOGt6T78nq9E4x8QR/3nU0dgDc
         lOIJSvaBeM1UNKkUI2PwY68ypenSxjaLwr/lmrBRv9sqkLcP6o18tqSVrnfd9tl4YLTD
         odBgJnMmwrQYzWjZ5UPuwZhur8LZCcQtJKqVBcmPU0ihtQ4qPUG0lENnLVXTmvVO+gZJ
         4ppzGeHJ1xDFMk9gwRdT3jHjPktpILcZ2j5fp1ButLundivA2JCP9mErhOR1qCMTSoUO
         eq1c8UOgXOvHo0zFn8C+yOPDvXqwY2H+kWjNEQQbEmmJle3BvDNQGpaE8xrSFfTb3x+j
         JqQA==
X-Forwarded-Encrypted: i=1; AJvYcCULccXd5hTWv3C+t+Q22RTARBR0aCrl0tWmLWSijyZWSBhgxUkVH0z7IJaS2RnOSgoneKIWpaEd@vger.kernel.org, AJvYcCWBoFmLabCfngXBHnd3mXnkm8cjWwyPs7ans+LkBSmIMlv9+JjFmJQUgK6bcQa7u5yy5IFGkbSrHZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3juFgkKRU0PnsyqCGjFuqg54iFjacY6fPMtDkmURI5qShJMV+
	HraPsy04/d52Dk9LnIOTaGNH9G8NOs0y4h2OEREExAwexoN+wg0B
X-Gm-Gg: ASbGnctWrmk+biRqg01IJyeqZ3R6sj16sJh+eEEoqDIg963nVI3wgOfqtI7WKRpktPA
	Zw1UUQ9UEwL1u5RDV60rk1wk64tpfqo7zD6t9nFrFJ2C0VuwRjVxSJ9MNTQPmmOM2mfmDwprCPU
	r5D1ytdFQP91stwj0n9HaTwKtSARZI54NxuA13Zs2g/SZrH2uYJJfjfL/u26ki1eSIq8p0v/dq0
	Jl/7FEiq+aSXW9uT7vBTM6fP2SMwtykwpFAqg1eQC72JtBFn7GgHkXBOA==
X-Google-Smtp-Source: AGHT+IGLJ1W2T/hdbQdiCIBZkecDQtKrwoetGyA3/aLLuNgM4a1Dyf+OebwoRNCRaca4jYV/KL/34w==
X-Received: by 2002:a5d:6c68:0:b0:385:df84:8496 with SMTP id ffacd0b85a97d-38880ac60d1mr5709653f8f.3.1734229063677;
        Sat, 14 Dec 2024 18:17:43 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8046dabsm4111731f8f.81.2024.12.14.18.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 18:17:42 -0800 (PST)
Message-ID: <da90f64c-260a-4329-87bf-1f9ff20a5951@gmail.com>
Date: Sun, 15 Dec 2024 04:17:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net v2] net: wwan: t7xx: Fix FSM command timeout issue
To: Jinjian Song <jinjian.song@fibocom.com>,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
 corbet@lwn.net, linux-mediatek@lists.infradead.org, helgaas@kernel.org,
 danielwinkler@google.com, korneld@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org
References: <20241213064720.122615-1-jinjian.song@fibocom.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241213064720.122615-1-jinjian.song@fibocom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jinjian,

Nice catch! Suddenly, the proposed fix is not complete, we still have 
issues with memory use after free. Please find details below.

On 13.12.2024 08:47, Jinjian Song wrote:
> When driver processes the internal state change command, it use an
> asynchronous thread to process the command operation. If the main
> thread detects that the task has timed out, the asynchronous thread
> will panic when executing the completion notification because the
> main thread completion object has been released.
> 
> BUG: unable to handle page fault for address: fffffffffffffff8
> PGD 1f283a067 P4D 1f283a067 PUD 1f283c067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> RIP: 0010:complete_all+0x3e/0xa0
> [...]
> Call Trace:
>   <TASK>
>   ? __die_body+0x68/0xb0
>   ? page_fault_oops+0x379/0x3e0
>   ? exc_page_fault+0x69/0xa0
>   ? asm_exc_page_fault+0x22/0x30
>   ? complete_all+0x3e/0xa0
>   fsm_main_thread+0xa3/0x9c0 [mtk_t7xx (HASH:1400 5)]
>   ? __pfx_autoremove_wake_function+0x10/0x10
>   kthread+0xd8/0x110
>   ? __pfx_fsm_main_thread+0x10/0x10 [mtk_t7xx (HASH:1400 5)]
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x38/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1b/0x30
>   </TASK>
> [...]
> CR2: fffffffffffffff8
> ---[ end trace 0000000000000000 ]---
> 
> After the main thread determines that the task has timed out, mark
> the completion invalid, and add judgment in the asynchronous task.
> 
> Fixes: d785ed945de6 ("net: wwan: t7xx: PCIe reset rescan")

The completion waiting was introduced in a different commit. I believe, 
the fix tag should be 13e920d93e37 ("net: wwan: t7xx: Add core components")

> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
> ---
>   drivers/net/wwan/t7xx/t7xx_state_monitor.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
> index 3931c7a13f5a..57f1a7730fff 100644
> --- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
> +++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
> @@ -108,7 +108,8 @@ static void fsm_finish_command(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command
>   {
>   	if (cmd->flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
>   		*cmd->ret = result;

The memory for the result storage is allocated on the stack as well. And 
writing it unconditionally can cause unexpected consequences.

> -		complete_all(cmd->done);
> +		if (cmd->done)
> +			complete_all(cmd->done);
>   	}
>   
>   	kfree(cmd);
> @@ -503,8 +504,10 @@ int t7xx_fsm_append_cmd(struct t7xx_fsm_ctl *ctl, enum t7xx_fsm_cmd_state cmd_id
>   
>   		wait_ret = wait_for_completion_timeout(&done,
>   						       msecs_to_jiffies(FSM_CMD_TIMEOUT_MS));
> -		if (!wait_ret)
> +		if (!wait_ret) {
> +			cmd->done = NULL;

We cannot access the command memory here, since fsm_finish_command() 
could release it already.

>   			return -ETIMEDOUT;
> +		}
>   
>   		return ret;
>   	}

Here we have an ownership transfer problem and a driver author has tried 
to solve it, but as noticed, we are still experiencing issues in case of 
timeout.

The command completion routine should not release the command memory 
unconditionally. Looks like the references counting approach should help 
us here. E.g.
1. grab a reference before we put a command into the queue
1.1. grab an extra reference if we are going to wait the completion
2. release the reference as soon as we are done with the command execution
3. in case of completion waiting release the reference as soon as we are 
done with waiting due to completion or timeout

Could you try the following patch? Please note, besides the reference 
counter introduction it also moves completion and result storage inside 
the command structure as advised by the completion documentation.


--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.h
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
@@ -109,8 +109,9 @@ struct t7xx_fsm_command {
  	struct list_head	entry;
  	enum t7xx_fsm_cmd_state	cmd_id;
  	unsigned int		flag;
-	struct completion	*done;
-	int			*ret;
+	struct completion	done;
+	int			result;
+	struct struct kref	refcnt;
  };

  struct t7xx_fsm_notifier {
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -97,14 +97,20 @@ void t7xx_fsm_broadcast_state(struct t7xx_fsm_ctl 
*ctl, enum md_state state)
  	fsm_state_notify(ctl->md, state);
  }

+static void fsm_release_command(struct kref *ref)
+{
+	struct t7xx_fsm_command *cmd = container_of(ref, typeof(*cmd), refcnt);
+	kfree(cmd);
+}
+
  static void fsm_finish_command(struct t7xx_fsm_ctl *ctl, struct 
t7xx_fsm_command *cmd, int result)
  {
  	if (cmd->flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
-		*cmd->ret = result;
+		cmd->result = result;
  		complete_all(cmd->done);
  	}

-	kfree(cmd);
+	kref_put(&cmd->refcnt, fsm_release_command);
  }

  static void fsm_del_kf_event(struct t7xx_fsm_event *event)
@@ -396,7 +402,6 @@ static int fsm_main_thread(void *data)

  int t7xx_fsm_append_cmd(struct t7xx_fsm_ctl *ctl, enum 
t7xx_fsm_cmd_state cmd_id, unsigned int flag)
  {
-	DECLARE_COMPLETION_ONSTACK(done);
  	struct t7xx_fsm_command *cmd;
  	unsigned long flags;
  	int ret;
@@ -408,11 +413,13 @@ int t7xx_fsm_append_cmd(struct t7xx_fsm_ctl *ctl, 
enum t7xx_fsm_cmd_state cmd_id
  	INIT_LIST_HEAD(&cmd->entry);
  	cmd->cmd_id = cmd_id;
  	cmd->flag = flag;
+	kref_init(&cmd->refcnt);
  	if (flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
-		cmd->done = &done;
-		cmd->ret = &ret;
+		init_completion(&cmd->done);
+		kref_get(&cmd->refcnt);
  	}

+	kref_get(&cmd->refcnt);
  	spin_lock_irqsave(&ctl->command_lock, flags);
  	list_add_tail(&cmd->entry, &ctl->command_queue);
  	spin_unlock_irqrestore(&ctl->command_lock, flags);
@@ -422,10 +429,10 @@ int t7xx_fsm_append_cmd(struct t7xx_fsm_ctl *ctl, 
enum t7xx_fsm_cmd_state cmd_id
  	if (flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
  		unsigned long wait_ret;

-		wait_ret = wait_for_completion_timeout(&done,
+		wait_ret = wait_for_completion_timeout(&cmd->done,
  						       msecs_to_jiffies(FSM_CMD_TIMEOUT_MS));
-		if (!wait_ret)
-			return -ETIMEDOUT;
+		ret = wait_ret ? cmd->result : -ETIMEDOUT;
+		kref_put(&cmd->refcnt, fsm_release_command);

  		return ret;
  	}

--
Sergey

