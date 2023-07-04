Return-Path: <netdev+bounces-15283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6262746956
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 08:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2A4280E8F
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 06:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1F3EC7;
	Tue,  4 Jul 2023 06:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53358812
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 06:07:44 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948AD1A1
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 23:07:40 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26304be177fso2459079a91.1
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 23:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1688450860; x=1691042860;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNixbfk8FBtqqI9FWLjKeagM3Zp0gd6y0AGFZVFkvMY=;
        b=KOHPRfLjs/NfHPw36yDsgD3yUmXsl3Ll6nfO8BEVwZF7+L5+FEBnESS1RkoJcoY2VT
         fpP+78tJ+KJDTQsw8k7D2DXeVAvVRsTmQeDuwbHVvun/4RTIcyLKFJn5EGr0bJiEf1Ua
         f1DKTB6EP0WL2CgfPtffSc7aoW9ln/E5MiQCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688450860; x=1691042860;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNixbfk8FBtqqI9FWLjKeagM3Zp0gd6y0AGFZVFkvMY=;
        b=A06VALdAHzIpdwKZkjHdNKAmuyiH2KeFSgDYL1Ml4dDYTXt7HsPUOf8YhVuZPXZXdt
         AI2BY+9D2cqnUIxQgenl/wqK8zhqZ4Fl57sqPQ4m5G+F2OMBADuHIQ4JC5ubBfvSucpN
         e2y3VTDr6kJyv7eFwy8mzIqKoq8RH5KD2ixRosO7KKzWHLheMOx+Of0cr6HzVfw7Ua6b
         rQs0Zp+uZ5SkYy5mH4lkA+TqotweC41bvgCISaRcfQO7XY6KufKCtg0UqCch62Po0ush
         ikxpSZdYYSebUNgbBsAAR/xeEqn0lbzHWS+MEqrgK1C+WhyXib/tD3gxsfwR80L2FQ5J
         U7zw==
X-Gm-Message-State: ABy/qLbpKNbgQt3jjcWpId47S9SjPnqHz26S2SSnE8hblHoxeyWG3R0G
	U65sbGoCWBWTuOBiGLsPjb/eVg==
X-Google-Smtp-Source: APBJJlGZoXtMm3LND/qiqxMIiGkb34491nNgLwaJzaGoFoGUSjxzYQ0+qioH1JxjbAqHr+iwNQYRMw==
X-Received: by 2002:a17:90a:8281:b0:262:ef90:246d with SMTP id g1-20020a17090a828100b00262ef90246dmr10326064pjn.23.1688450860022;
        Mon, 03 Jul 2023 23:07:40 -0700 (PDT)
Received: from ubuntu ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a019600b00262e0c91d27sm15797006pjc.48.2023.07.03.23.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 23:07:39 -0700 (PDT)
Date: Mon, 3 Jul 2023 23:07:34 -0700
From: Hyunwoo Kim <v4bel@theori.io>
To: sam@mendozajonas.com
Cc: davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org,
	netdev@vger.kernel.org, imv4bel@gmail.com, v4bel@theori.io
Subject: [report?] A race condition is suspected.
Message-ID: <20230704060734.GA38702@ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear all,

From the code, it looks like a use-after-free due to a race condition 
could be caused by the lack of a proper lock between the ncsi_dev_work() 
worker and the vlan ioctl:
```
                  cpu0                                          cpu1

         ncsi_dev_work()
           ncsi_configure_channel()
             set_one_vid()
               rcu_read_lock()
                                                            sock_ioctl()
                                                              vlan_ioctl_handler()
                                                                unregister_vlan_dev()
                                                                  vlan_vid_del()
                                                                    __vlan_vid_del()
                                                                      vlan_kill_rx_filter_info()
                                                                        ncsi_vlan_rx_kill_vid()
                                                                          list_del_rcu(&vlan->list);
                                                                          kfree(vlan);
               vid = vlan->vid;    // use-after-free?
               rcu_read_unlock()
```

However, I do not have a device that uses the ncsi_dev_work() worker, 
so I have not been able to debug this.

Can a race condition like this actually happen, and if so, it seems 
like we need to change `kfree(vlan);` to `kfree_rcu(vlan)`, or add 
an appropriate lock to the worker.


Regards,
Hyunwoo Kim

