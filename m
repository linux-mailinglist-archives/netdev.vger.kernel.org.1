Return-Path: <netdev+bounces-30534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43243787BFB
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 01:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A48D1C20F06
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 23:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7E8C12E;
	Thu, 24 Aug 2023 23:27:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C07E
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 23:27:27 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAF4A1;
	Thu, 24 Aug 2023 16:27:26 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76ce59842c1so22124985a.3;
        Thu, 24 Aug 2023 16:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692919646; x=1693524446;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKfUzKb+moVRVD1OhhkPh9UKTtSvWaehu8weVUwd3Eo=;
        b=cAAxU1/uNtWjZ+NjQ15skzXU/jYj6so77FDkM7b/t+8AESpN0ToXMS8jIsywvFSIQO
         uGodsmrk8/VZPvvUqc9+WgaRBKnZ/x1YJar71UVpeZRtUn9R36u9+scH4RkrHvKbGmn7
         qxXjvQ+iHFeOoLAdmsjLawplY1Cam502oOJbk1oY7/FUg2PT4VbWZQVmGoo6+eZO/rLQ
         HyogZkZUKEQCGPHRdmwBXgxgUW9PhymyVoeVB4lN4JIDb9LpxyZDTBYerSf0atwZGI+M
         A80eW0II8O8TxczpYcbrg50mWwfrWSmAzngOB9nFheRQcpPGMUCvuYdm+rCufbVfandI
         hPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692919646; x=1693524446;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yKfUzKb+moVRVD1OhhkPh9UKTtSvWaehu8weVUwd3Eo=;
        b=M5L78K4p0CICIDIv9SQiC+mGH3zOUvc91IY6yETKCYcKI0KCwzVdpTrvNCuylqWAdU
         rDO6TYGXunrYT+fQmXSiqAIEH7TmpXo86FQ6WlEMBXP7LxW0Fy395GSB0AhRGqqRKEBB
         9AluH2NJ52+i/bXOOo8wIX6CNM/9uffXpEgKHUaPmzGbcPUnT4x/5d4btXTHiY8oL5CP
         zcP8uVMzTpHZkLIHazMguVDbHOwvYs3gnhbjbd8OD8JFMo13ZM7Je+vWX+9inCMgts1I
         +YXgpDrQIy5bp8V0drjdKmpYwmJX+UcAAjk+vlSjP3gKvOBXza+gGbn+NbDaaZOJW/TS
         2c3w==
X-Gm-Message-State: AOJu0YxASbNtctLPHDaeY25gTuJG6Fa5S3JFiaWNdURzkCB9AvTJDfWQ
	6zar0nR/YF1B8jR5oylbOs0=
X-Google-Smtp-Source: AGHT+IHJMe3uiyWF2JRpLpsQnwj+Ad3uh5evDhJ/ndu75Vhbplxi634ERY2p6zKa6luKrWbZUyy5ZA==
X-Received: by 2002:a05:620a:25c8:b0:76c:c99b:8db with SMTP id y8-20020a05620a25c800b0076cc99b08dbmr18487896qko.17.1692919645713;
        Thu, 24 Aug 2023 16:27:25 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id d4-20020ac86144000000b0040ff25d8712sm167666qtm.18.2023.08.24.16.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 16:27:25 -0700 (PDT)
Date: Thu, 24 Aug 2023 19:27:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>, 
 davem@davemloft.net, 
 keescook@chromium.org, 
 luto@amacapital.net, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 linux-kselftest@vger.kernel.org, 
 shuah@kernel.org, 
 wad@chromium.org, 
 kuba@kernel.org, 
 edumazet@google.com, 
 linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org, 
 Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Message-ID: <64e7e75ce75de_4b65d29470@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230824214506.137505-2-mahmoudmatook.mm@gmail.com>
References: <20230824214506.137505-2-mahmoudmatook.mm@gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/net: replace ternary operator with
 min()/max()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mahmoud Maatuq wrote:
> Fix the following coccicheck warning:
> tools/testing/selftests/net/udpgso_bench_tx.c:297:18-19: WARNING opportunity for min()
> tools/testing/selftests/net/udpgso_bench_tx.c:354:27-28: WARNING opportunity for min()
> tools/testing/selftests/net/so_txtime.c:129:24-26: WARNING opportunity for max()
> tools/testing/selftests/net/so_txtime.c:96:30-31: WARNING opportunity for max()
> 
> Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>

When submitting a new version of a patch, please resubmit the entire
series. I think 1/2 is missing, per patchwork?

